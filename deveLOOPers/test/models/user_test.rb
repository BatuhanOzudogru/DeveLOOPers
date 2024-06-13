require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(password: "password", nickname: "user1")
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user without password" do
    user = User.new(email: "user@example.com", nickname: "user1")
    assert_not user.save, "Saved the user without a password"
  end

  test "should not save user with duplicate email" do
    user1 = users(:one)
    user2 = User.new(email: user1.email, password: "password", nickname: "user2")
    assert_not user2.save, "Saved the user with a duplicate email"
  end

  test "should save user with valid attributes" do
    user = User.new(email: "unique@example.com", password: "password", nickname: "user3")
    assert user.save, "Failed to save the user with valid attributes"
  end

  test "should set nickname before validation" do
    user = User.new(email: "test@example.com", password: "password")
    user.valid?
    assert_equal "test", user.nickname, "Failed to set nickname before validation"
  end
end
