class RestaurantResultMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.restaurant_result_mailer.result_release.subject
  #
  def result_release
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
