class ResponsesController < ApplicationController
  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    @response.save
    redirect_to root_path
  end

  def response_params
    params.require(:response).permit(:budget, :location)
end
