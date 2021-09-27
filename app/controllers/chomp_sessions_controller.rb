class ChompSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_chomp_session, only: %i[edit update show]
  before_action :set_chomp_session_specific, only: %i[success result]

  def dashboard
    @chomp_sessions = ChompSession.where(user: current_user).order(status: :desc, date: :asc)
    @responses = Response.where(user: current_user)
  end

  def new
    @chomp_session = ChompSession.new
  end

  def create
    @chomp_session = ChompSession.new(chomp_params)
    @chomp_session.user = current_user
    @chomp_session.name = "Your Meeting Created on #{Time.now}" if @chomp_session.name == ""
    if @chomp_session.save
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
      # algorithm to get recommendation
      @restaurant = Restaurant.all.sample
      @chomp_session.restaurant = @restaurant
      @chomp_session.status = "closed"
      @chomp_session.save
    else
      @restaurant = @chomp_session.restaurant
    end
    # ============== Mailing logic
    @responses_arr = Response.where(chomp_session: @chomp_session.id)
    @responses_arr.each do |response|
      next if response.user.nil?

      RestaurantResultMailer.with(restaurant: @restaurant, chomp_session: @chomp_session, response: response).result_release.deliver_later
    end
    # ============== End of mailing logic
    redirect_to restaurant_path(@restaurant)
  end

  private

  def chomp_params
    params.require(:chomp_session).permit(:name, :date, :time, :session_expiry)
  end

  def set_chomp_session
    @chomp_session = ChompSession.find_puid(params[:id])
  end

  def set_chomp_session_specific
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
  end
end
