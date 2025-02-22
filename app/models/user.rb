class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  # TODO has_secure_passwordとpasswordのバリデーションを追加
end
