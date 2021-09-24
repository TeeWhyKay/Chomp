class ResponsesController < ApplicationController
  # def new
  #   @response = Response.new
  #   @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
  # end

  def create
    coords = split_location(params[:location]) unless params[:location].empty?
    @response = Response.new(response_params)
    @response.user = current_user
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.cuisine.reject { |c| c.empty? }
    @response.latitude = coords[:latitude]
    @response.longitude = coords[:longitude]
    if @response.save
      redirect_to chomp_session_success_url(@chomp_session)
      # change later to waiting page
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

  # def show
  #   @response = Response.find(params[:id])
  # end

  private

  # def find_response
  #   @response_id = Response.find(params[:response_id])
  # end

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
end
