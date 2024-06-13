class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  before_validation :set_nickname, on: :create

  validates :nickname, presence: true, uniqueness: true

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
  
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20],
        nickname: data['nickname'] || data['email'].split('@').first.gsub('.', '')
      )
    end
    user
  end

  private

  def set_nickname
    self.nickname = email.split('@').first if nickname.blank?
  end
end
