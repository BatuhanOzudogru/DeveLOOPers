class Article < ApplicationRecord
    enum status: {unpublished:0,published:1}
    validates :title, presence:true, uniqueness: true
    validates :content, presence: true
    after_initialize :set_default_status, if: :new_record?

    private

    def set_default_status
        self.status ||= :unpublished
    end
    
end
