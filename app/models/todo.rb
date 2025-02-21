class Todo < ApplicationRecord
  attribute :is_completed, default: -> { false }

  validates :title, presence: true
  validates :content, presence: true
end
