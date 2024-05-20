class Article < ApplicationRecord
    enum status: {unpublished:0,published:1}

    after_initialize :set_defaiult_status, if: :new_record?

    private

    def set_defaiult_status
        selt.status ||= :unpublished
    end
    
end
