require 'test_helper'

class ResponseMailerTest < ActionMailer::TestCase
  test "create_response" do
    mail = ResponseMailer.create_response
    assert_equal "Create response", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "update_response" do
    mail = ResponseMailer.update_response
    assert_equal "Update response", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
