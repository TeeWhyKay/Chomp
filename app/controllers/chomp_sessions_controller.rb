class ChompSessionsController < ApplicationController
  def new
    @chomp_session = ChompSession.new
  end


  def create
    @chomp_session = ChompSession.new(chomp_params)
    @chomp_session.user = current_user
    @chomp_session.name = "Your Meeting Created on #{Time.now}" if @chomp_session.name == ""
    if @chomp_session.save
      # ? ONLY UNCOMMENT THIS IF YOU PREFER NO EMAIL SENDING EVEN WHEN NEW CHOMP SESSION IS CREATED VIA CONSOLE (RAILS C)
      # ? THIS MEANS YOU HAVE TO COMMENT OUT THE MAILING METHOD IN CHOMPSESSION.RB
      mail = ChompSessionMailer.with(chomp_session: @chomp_session).create_confirmation
      mail.deliver_now
      redirect_to success_path
    else
      render :new
    end
  end

  def success
  end

  def show
  end

  private

  def chomp_params
    params.require(:chomp_session).permit(:name, :date, :time, :session_expiry)
  end
end
