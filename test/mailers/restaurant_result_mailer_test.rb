require 'test_helper'

class RestaurantResultMailerTest < ActionMailer::TestCase
  test "result_release" do
    mail = RestaurantResultMailer.result_release
    assert_equal "Result release", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
