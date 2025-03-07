# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Rails.env.development?
  # Admin ユーザー
  User.find_or_create_by(email: 'admin@example.com') do |user|
    user.password = 'Password123!'
    user.is_admin = true
  end

  # テストユーザー
  10.times.each_with_index do |_, i|
    user = FactoryBot.create(:user, email: "test#{i+1}@example.com")
    3.times do
      FactoryBot.create(:todo, user: user)
    end
  end
end
