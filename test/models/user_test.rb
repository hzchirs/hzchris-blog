require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:chris)
  end

  test "should not save user without email" do
    @user.email = ""
    assert_not @user.save
  end

  test "should not save user with invalid email" do
    @user.email = 'hello, this is invalid email'
    assert_not @user.save
  end
end
