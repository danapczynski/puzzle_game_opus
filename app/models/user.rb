class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_many  :scores
  has_many  :levels, through: :scores

  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation
end