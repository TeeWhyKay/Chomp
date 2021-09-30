class RestaurantResultMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.restaurant_result_mailer.result_release.subject
  #
  def result_release
    @restaurant = params[:restaurant]
    chomp_session = params[:chomp_session]
    response = params[:response]
    mail(
      to: response.user.email,
      subject: "#{chomp_session.name}'s decision is out! Enjoy your meal at #{@restaurant.name}"
    )
  end
end
