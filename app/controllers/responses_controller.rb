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
