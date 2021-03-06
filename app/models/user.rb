class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, :email_format => {:message => 'is not formatted correctly'}
  validates :password, presence: true
  has_many  :scores
  has_many  :levels, through: :scores

  has_secure_password

  def new_player?
    levels.empty?
  end

  def last_level_completed
    return nil if new_player?
    levels.last
  end

  def next_level
    return Level.find_by_level_number(1) if new_player?
    Level.find_by_level_number(last_level_completed.level_number + 1)
  end

  def unique_levels
    levels.uniq
  end

  def best_score(level)
    if levels.include?(level)
      score = scores.where(level_id: level.id).min_by(&:completion_time).completion_time
      score == 1 ? "#{score} sec" : "#{score} secs"
    else
      "N/A"
    end
  end
end
