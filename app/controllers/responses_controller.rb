class ResponsesController < ApplicationController
  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    if @response.save
      redirect_to success_path

    else
      render :new
    end
  end

  private

  def response_params
    params.require(:response).permit(:budget, :location)
  end
end
