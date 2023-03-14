class User < ApplicationRecord
  has_secure_password

  validates :name, length: { minimum: 1, maximum: 20 }
  validates :mail_address, presence: true, uniqueness: true, email: {
    message: '正式なメールアドレスを入力してください。'
  }
  validates :password, length: { minimum: 10 }, on: :create

  def self.get_public(user_id)
    user = find(user_id).attributes
    user.delete('password_digest')

    user
  end
end
