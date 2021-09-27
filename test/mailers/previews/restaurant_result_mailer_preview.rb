# Preview all emails at http://localhost:3000/rails/mailers/restaurant_result_mailer
class RestaurantResultMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/restaurant_result_mailer/result_release
  def result_release
    RestaurantResultMailer.result_release
  end

end
