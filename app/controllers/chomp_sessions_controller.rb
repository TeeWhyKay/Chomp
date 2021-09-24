class ChompSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def new
    @chomp_session = ChompSession.new
  end

  def create
    @chomp_session = ChompSession.new(chomp_params)
    @chomp_session.user = current_user
    @chomp_session.name = "Your Meeting Created on #{Time.now}" if @chomp_session.name == ""
    if @chomp_session.save
      redirect_to chomp_session_success_url(@chomp_session)
    else
      render :new
    end
  end

  def edit
    @chomp_session = ChompSession.find_puid(params[:id])
  end

  def update
    @chomp_session = ChompSession.find_puid(params[:id])
    @chomp_session.update(chomp_params)
    if @chomp_session.save
      update_mail = ChompSessionMailer.with(chomp_session: @chomp_session).update_chomp
      update_mail.deliver_now
      redirect_to chomp_session_success_url(@chomp_session)
    else
      render :new
    end
  end

  def success
    @chomp_session = ChompSession.find_puid(params[:chomp_session_id])
  end

  def show
    @response = Response.new
    @chomp_session = ChompSession.find_puid(params[:id])
  end

  private

  def chomp_params
    params.require(:chomp_session).permit(:name, :date, :time, :session_expiry)
  end
end
