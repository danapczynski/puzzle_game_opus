class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many  :scores
  has_many  :levels, through: :scores

  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation

  def new_player?
    levels.empty?
  end

  def last_level_completed
    levels.last
  end

  def next_level
    Level.find_by_level_number(last_level_completed.level_number + 1)
  end
end