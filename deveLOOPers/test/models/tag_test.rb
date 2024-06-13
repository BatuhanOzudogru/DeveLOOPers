require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "should not save tag without name" do
    tag = Tag.new
    assert_not tag.save, "Saved the tag without a name"
  end

  test "should not save tag with duplicate name" do
    tag1 = tags(:one)
    tag2 = Tag.new(name: tag1.name)
    assert_not tag2.save, "Saved the tag with a duplicate name"
  end

  test "should save tag with valid attributes" do
    tag = Tag.new(name: "Unique Tag")
    assert tag.save, "Failed to save the tag with valid attributes"
  end
end