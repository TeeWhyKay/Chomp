class ResponseMailer < ApplicationMailer
  before_action :set_response_chomp_session

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.response_mailer.create_response.subject
  #
  def create_response
    mail(
      to: @response.user.email,
      subject: "Your response for '#{@chomp_session.name}' is saved! (#{@chomp_session.public_uid})"
    )
  end

  def update_response
    mail(
      to: @response.user.email,
      subject: "Your response for '#{@chomp_session.name}' is updated! (#{@chomp_session.public_uid})"
    )
  end

  private

  def set_response_chomp_session
    @response = params[:response]
    @chomp_session = params[:chomp_session]
  end
end
