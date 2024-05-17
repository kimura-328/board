class User < ApplicationRecord
  before_create :generate_unique_id
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :posts, dependent: :destroy
  private

  def generate_unique_id
    self.unique_id = SecureRandom.alphanumeric(20)
  end
end
