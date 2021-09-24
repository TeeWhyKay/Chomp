class ResponseMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.response_mailer.create_response.subject
  #
  def create_response
    @response = params[:response]

    mail(
      to:       @response.user.email,
      subject:  "Your response for '#{@response.chomp_session.name}' is saved!"
    )
  end

  def update_response
    @response = params[:response]

    mail(
      to:       @response.user.email,
      subject:  "Your response for '#{@response.chomp_session.name}' is updated!"
    )
  end
end
