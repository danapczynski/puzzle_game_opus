class Score < ApplicationRecord
  validates :user_id, presence: true
  validates :level_id, presence: true
  validates :completion_time, presence: true
  belongs_to :user
  belongs_to :level
end
