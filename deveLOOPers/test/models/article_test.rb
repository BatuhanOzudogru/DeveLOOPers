require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new(content: "Some content", user: users(:one))
    assert_not article.save, "Saved the article without a title"
  end

  test "should not save article with duplicate title" do
    article1 = articles(:one)
    article2 = Article.new(title: article1.title, content: "Different content", user: users(:one))
    assert_not article2.save, "Saved the article with duplicate title"
  end

  test "should save article with valid attributes" do
    article = Article.new(title: "Unique title", content: "Some content", user: users(:one))
    assert article.save, "Failed to save the article with valid attributes"
  end

  test "should return published articles" do
    published_articles = Article.published
    assert_includes published_articles, articles(:one)
    assert_not_includes published_articles, articles(:two)
  end

  test "should search articles by title or content" do
    results = Article.search("Sample")
    assert_not results.empty?, "Search did not return any results"
  end
end
