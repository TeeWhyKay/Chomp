class ResponseMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.response_mailer.create_response.subject
  #
  def create_response
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.response_mailer.update_response.subject
  #
  def update_response
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
