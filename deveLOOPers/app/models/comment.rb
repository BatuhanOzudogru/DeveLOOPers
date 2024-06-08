class Comment < ApplicationRecord
  validates :body, presence: true
  validates :commenter, presence: true
  
  belongs_to :article
  belongs_to :user



  def written_by?(current_user)
    user == current_user
  end




end
