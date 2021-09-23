class ResponsesController < ApplicationController
  def new
    @chomp_session = ChompSession.find(params[:chomp_session_id])
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    @response.user = current_user
    @response.chomp_session = ChompSession.find(params[:chomp_session_id])
    @response.cuisine.reject { |c|  c.empty? }

    if @response.save
      redirect_to root_path

    else
      render :new
    end
  end

  def show
    @response = Response.find(params[:id])
  end

  private

  # def find_response
  #   @response_id = Response.find(params[:response_id])
  # end

  def response_params
    params.require(:response).permit(:budget, :location, cuisine: [])
  end
end