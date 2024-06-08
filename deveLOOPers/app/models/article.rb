class Article < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    has_rich_text :content
  
    scope :published, -> { where(published: true) }

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_and_belongs_to_many :tags

    accepts_nested_attributes_for :tags
    private
    
end
