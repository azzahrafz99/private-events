class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :username, presence:true
  validates :email, presence:true
  validates :password, presence:true
  validates :password_confirmation, presence:true

  has_many :events

  has_secure_password

  def User.new_remember_token
      SecureRandom.urlsafe_base64
  end

  def User.digest(token)
      Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
        self.remember_token = User.digest(User.new_remember_token)
    end
end
