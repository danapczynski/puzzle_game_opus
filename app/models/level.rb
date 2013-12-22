class Level < ActiveRecord::Base
  has_many :scores
  has_many :users, through: :scores
  has_and_belongs_to_many :blocks
  
end