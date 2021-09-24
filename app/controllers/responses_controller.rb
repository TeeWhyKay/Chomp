class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_response, only: %i[show edit update]

  def create
    @response = Response.new(response_params)
    @response.user = current_user
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
    @response.chomp_session = @chomp_session
    @response.cuisine.reject { |c| c.empty? }

    if @response.save
      ResponseMailer.with(response: @response, chomp_session: @chomp_session).create_response.deliver_later if user_signed_in?
      redirect_to chomp_session_response_url(@chomp_session, @response)
    else
      render :new
    end
  end

  def show
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
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
    params.require(:response).permit(:budget, :location, cuisine: [])
  end

  def set_response
    @response = Response.find(params[:id])
  end
end
