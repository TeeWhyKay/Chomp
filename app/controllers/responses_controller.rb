class ResponsesController < ApplicationController
  # def new
  #   @response = Response.new
  #   @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
  # end

  def create
    @response = Response.new(response_params)
    @response.user = current_user
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.cuisine.reject { |c| c.empty? }

    if @response.save
      redirect_to chomp_session_success_url(@chomp_session)
      # change later to waiting page
    else
      render :new
    end
  end

  def reverse_geocode
    # assume user is not a guest
    #  current_user.lat = params[:latitude]
    #  current_user.lng = params[:longitude]
    #  address = current_user.reverse_geocode
    @response = Response.new(latitude: params[:latitude], longitude: params[:longitude])
    address = @response.reverse_geocode
    # how to pass this partial response? and make use of it during response creation?
    respond_to do |format|
      return format.json { render json: { address: address } }
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
    params.require(:response).permit(:budget, :location, cuisine: [])
  end
end
