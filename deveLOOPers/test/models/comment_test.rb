require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "should not save comment without body" do
    comment = Comment.new(commenter: "John Doe")
    assert_not comment.save, "Saved the comment without a body"
  end

  test "should not save comment without commenter" do
    comment = Comment.new(body: "Sample comment")
    assert_not comment.save, "Saved the comment without a commenter"
  end

  test "should save comment with valid attributes" do
    comment = Comment.new(body: "Sample comment", commenter: "John Doe", article: articles(:one), user: users(:one))
    assert comment.save, "Failed to save the comment with valid attributes"
  end

  test "should return approved comments" do
    approved_comments = Comment.approved
    assert approved_comments.all? { |comment| comment.state == 'approved' }, "Returned comments that are not approved"
  end

  test "should check if comment is written by a user" do
    comment = comments(:one)
    assert comment.written_by?(users(:one)), "Failed to identify the user who wrote the comment"
  end
end