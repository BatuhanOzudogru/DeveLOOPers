class Article < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    has_rich_text :content
  
    scope :published, -> { where(published: true) }

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_and_belongs_to_many :tags

    accepts_nested_attributes_for :tags

    

    def self.search(query)
        if query.present?
          if query.start_with?('tag:')
            tag_name = query.split(':')[1]
            joins(:tags).where(tags: { name: tag_name }).published
          else
            where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%").published
          end
        else
          published
        end
      end
    
      private
    
end