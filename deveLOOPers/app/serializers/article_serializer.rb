class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :published
  
  has_many :approved_comments
  has_many :tags

  def approved_comments
    object.comments.approved
  end

  def tags
    object.tags.pluck(:name)
  end
end
