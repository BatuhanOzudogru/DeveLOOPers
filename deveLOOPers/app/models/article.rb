class Article < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    has_rich_text :content
  
    scope :published, -> { where(published: true) }

    belongs_to :user
    has_many :comments, dependent: :destroy
    private
    
end
