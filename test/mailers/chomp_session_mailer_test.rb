require 'test_helper'

class ChompSessionMailerTest < ActionMailer::TestCase
  test "create_chomp" do
    mail = ChompSessionMailer.create_chomp
    assert_equal "Create chomp", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
