class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_one   :campaign

  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation
end