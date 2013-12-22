class Block < ActiveRecord::Base
  validates :nickname, presence: true
  validates :shape, presence: true
  has_and_belongs_to_many :levels
  before_create :populate_shape

  attr_accessible :nickname

  def populate_shape
    f = File.open('public/blocks/' + nickname + '.html')
    shape_html = ''
    f.each do |line|
      shape_html += line
    end
    self.shape = shape_html
  end

  def read_shape
    self.shape.html_safe
  end

end