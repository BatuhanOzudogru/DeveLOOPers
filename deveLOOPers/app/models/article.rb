class Article < ApplicationRecord
    validates :title, presence:true, uniqueness: true
    has_rich_text :content
    private
    
end
