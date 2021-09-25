class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_response, only: %i[show edit update]

  def create
    coords = split_location(params[:location]) unless params[:location].empty?
    @response = Response.new(response_params)
    @response.user = current_user
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.chomp_session = @chomp_session
    @response.cuisine.reject { |c| c.empty? }
    @response.latitude = coords[:latitude]
    @response.longitude = coords[:longitude]
    if @response.save
      ResponseMailer.with(response: @response, chomp_session: @chomp_session).create_response.deliver_later if user_signed_in?
      redirect_to chomp_session_response_url(@chomp_session, @response)
    else
      render :new
    end
  end

  def reverse_geocode
    # assume user is not a guest
    location = request.body.read
    location_json = JSON.parse(location)
    #  current_user.lat = params[:latitude]
    #  current_user.lng = params[:longitude]
    #  address = current_user.reverse_geocode
    @response = Response.new(location_json)
    address = @response.reverse_geocode
    # address = "test address"
    # how to pass this partial response? and make use of it during response creation?
    respond_to do |format|
      format.html
      format.json { render json: { address: address } }
    end
  end

  def show
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    redirect_to restaurant_path(@chomp_session.restaurant) if @chomp_session.status == "closed"
  end

  def edit
    redirect_to new_user_session_path unless user_signed_in?
    @chomp_session = @response.chomp_session
  end

  def update
    @response.update(response_params)
    @chomp_session = @response.chomp_session
    if @response.save
      ResponseMailer.with(response: @response, chomp_session: @chomp_session).update_response.deliver_later if user_signed_in?
      redirect_to chomp_session_response_url(@chomp_session, @response)
    else
      render :new
    end
  end

  private

  def response_params
    params.require(:response).permit(:budget, :address, cuisine: [])
  end

  def location_params
    params.permit!
  end

  def split_location(location)
    str_arr = location.split(',')
    str_arr.map { |str| str.to_f }
    return { latitude: str_arr[0], longitude: str_arr[1] }
  end

  def set_response
    @response = Response.find(params[:id])
  end
end
