class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_nickname, on: :create

  validates :nickname, presence: true, uniqueness: true

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  private

  def set_nickname
    self.nickname = email.split('@').first if nickname.blank?
  end
end
