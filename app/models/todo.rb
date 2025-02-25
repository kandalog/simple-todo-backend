class Todo < ApplicationRecord
  belongs_to :user

  attribute :is_completed, default: -> { false }

  validates :title, presence: true
  validates :content, presence: true
end
