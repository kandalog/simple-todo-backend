# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :todos, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}\z/

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX, message: "emailの形式が間違っています" }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: PASSWORD_REGEX, message: "パスワードは8桁以上で半角英大文字・小文字・数字・記号をそれぞれ1文字以上含む必要があります" }
end
