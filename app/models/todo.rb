# == Schema Information
#
# Table name: todos
#
#  id           :bigint           not null, primary key
#  title        :string
#  content      :text
#  is_completed :boolean
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_todos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Todo < ApplicationRecord
  belongs_to :user

  attribute :is_completed, default: -> { false }

  validates :title, presence: true
  validates :content, presence: true
end
