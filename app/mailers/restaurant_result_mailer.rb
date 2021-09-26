class RestaurantResultMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.restaurant_result_mailer.result_release.subject
  #
  def result_release
    restaurant_name = params[:restaurant].name
    chomp_session = params[:chomp_session]
    responses = Response.where(chomp_session: chomp_session.id)
    responses.each do |response|
      unless response.user.nil?
        mail(
          to: response.user.email,
          subject: "#{chomp_session.name}'s decision is out! Enjoy your meetup at #{restaurant_name}."
        )
      end
    end
  end
end
