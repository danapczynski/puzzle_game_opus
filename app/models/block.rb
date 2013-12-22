class Block < ActiveRecord::Base
  validates :nickname, presence: true
  validates :link_to_shape, presence: true
  has_and_belongs_to_many :levels

  attr_accessible :nickname, :link_to_shape

  def shape
    f = File.open(self.link_to_shape)
    str = ""
    f.each do |line|
      str += line
    end
    str.html_safe
  end

end