require 'sidekiq/api'
class ChompSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_chomp_session, only: %i[edit update show]
  before_action :set_chomp_session_specific, only: %i[success result]

  def dashboard
    @chomp_sessions = ChompSession.where(user: current_user).order(status: :desc, date: :asc)
    @responses = Response.where(user: current_user).order(created_at: :desc)
  end

  def new
    @chomp_session = ChompSession.new
  end

  def create
    @chomp_session = ChompSession.new(chomp_params)
    @chomp_session.user = current_user
    @chomp_session.name = "I can't decide on a name on #{Time.now}" if @chomp_session.name == ""
    if @chomp_session.save
      job = GenerateRestaurantJob.set(wait_until: @chomp_session.session_expiry.hours.from_now).perform_later(@chomp_session.id)
      @chomp_session.sidekiq_jid = job.provider_job_id
      @chomp_session.save
      ChompSessionMailer.with(chomp_session: @chomp_session).create_chomp.deliver_later
      redirect_to chomp_session_success_url(@chomp_session)
    else
      render :new
    end
  end

  def edit; end

  def update
    @chomp_session.update(chomp_params)
    if @chomp_session.save
      job = Sidekiq::ScheduledSet.new.find_job(@chomp_session.sidekiq_jid)
      job.reschedule(Time.now + @chomp_session.session_expiry.hours)
      ChompSessionMailer.with(chomp_session: @chomp_session).update_chomp.deliver_later
      redirect_to chomp_session_success_url(@chomp_session)
    else
      render :new
    end
  end

  def success; end

  def show
    @response = Response.new
    redirect_to restaurant_path(@chomp_session.restaurant) if @chomp_session.status == "closed"
  end

  def result
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    if @chomp_session.status == "pending"
      @restaurant = generate_restaurant(@chomp_session).first
      @restaurant = Restaurant.all.sample if @restaurant.nil?
      @chomp_session.restaurant = @restaurant
      @chomp_session.status = "closed"
      @chomp_session.save
      # send worker to cancel job
      ChompsessionCancellationJob.perform_later(@chomp_session.id)
    else
      @restaurant = @chomp_session.restaurant
    end

    @responses_arr = Response.where(chomp_session: @chomp_session.id)
    @responses_arr.each do |response|
      next if response.user.nil?

      RestaurantResultMailer.with(restaurant: @restaurant, chomp_session: @chomp_session, response: response).result_release.deliver_later
    end

    redirect_to restaurant_path(@restaurant)
  end

  private

  def chomp_params
    params.require(:chomp_session).permit(:name, :date, :time, :session_expiry, :invitees)
  end

  def set_chomp_session
    @chomp_session = ChompSession.find_puid(params[:id])
  end

  # input: chomp_session instance
  # output: one restaurant
  def generate_restaurant(chomp_session)
    # algorithm to get recommendation
    # based on chompsession ID, get all responses
    # find the lowest budget, convert to integer 1,2,3 or 4
    # get frequency table of cuisines. Get the highest frequency cuisinse.
    # If no highest frequency
    # Get middleground of all location responses and get the highest rated restaurant with the specified cuisine.
    responses = chomp_session.responses
    lowest_budget = responses.minimum('budget')
    restaurant_pricing = determine_pricing(lowest_budget.to_i)

    cuisine_arr = []
    responses.each do |response|
      response_cuisine = response.cuisine
      cuisine_arr << response_cuisine.slice!(1, response_cuisine.length) unless response_cuisine == [""]
    end
    cuisine_arr.flatten!(1)
    tallied_result = cuisine_arr.tally
    most_frequent_cuisine_kv = tallied_result.max_by { |_, value| value }

    # check tie
    tied_results = tallied_result.select { |_, v| v == most_frequent_cuisine_kv[1] }
    if tied_results.length == 1
      result_cuisine = most_frequent_cuisine_kv[0]
      # num_votes = most_frequent_cuisine_kv[1]
    else
      result_cuisine = tied_results.keys.sample
    end

    # location
    geographic_center = Geocoder::Calculations.geographic_center(responses)

    # restaurant within 5km of center ordered by rating and budget
    restaurant = Restaurant.where("pricing = ?", restaurant_pricing).cuisine_type(result_cuisine).near(geographic_center, 5).reorder('google_rating desc').limit(1)

    if restaurant.empty?
      restaurant = Restaurant.where("pricing = ?", restaurant_pricing).cuisine_type(result_cuisine).reorder('google_rating desc').limit(1)
    end
    return restaurant
  end

  def determine_pricing(budget)
    if budget > 50
      4
    elsif budget > 25
      3
    elsif budget > 10
      2
    else
      1
    end
  end

  def set_chomp_session_specific
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
  end
end
