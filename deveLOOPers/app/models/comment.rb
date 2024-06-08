class Comment < ApplicationRecord
  validates :body, presence: true
  validates :commenter, presence: true
  
  belongs_to :article
  belongs_to :user

  scope :approved, -> { where(state: 'approved') }
  scope :pending, -> { where(state: 'pending') }

  def written_by?(current_user)
    user == current_user
  end
end
