require 'test_helper'

class ChompSessionMailerTest < ActionMailer::TestCase
  test "create_confirmation" do
    mail = ChompSessionMailer.create_confirmation
    assert_equal "Create confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
