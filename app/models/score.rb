class Score < ActiveRecord::Base
  validates :user_id, presence: true
  validates :level_id, presence: true
  validates :completion_time, presence: true
  belongs_to :user
  belongs_to :level

  attr_accessible :completion_time, :level_id, :user_id

end