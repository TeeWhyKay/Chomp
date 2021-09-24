class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :edit, :update]
  def create
    @response = Response.new(response_params)
    @response.user = current_user
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.cuisine.reject { |c| c.empty? }

    if @response.save
      redirect_to chomp_session_response_url(@chomp_session, @response)
      # change later to waiting page
    else
      render :new
    end
  end

  def show
    @response = Response.find(params[:id])
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
  end

  def edit
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @response = Response.find(params[:id])
    @chomp_session = @response.chomp_session
  end

  def update
    @response = Response.find(params[:id])
    @response.update(response_params)
    @chomp_session = @response.chomp_session
    if @response.save
      redirect_to chomp_session_response_url(@chomp_session, @response)
    else
      render :new
    end
  end

  private

  def response_params
    params.require(:response).permit(:budget, :location, cuisine: [])
  end
end
