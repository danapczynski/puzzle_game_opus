class Block < ActiveRecord::Base
  validates :nickname, presence: true, uniqueness: true
  validates :shape, presence: true
  has_and_belongs_to_many :levels
  before_validation :populate_shape

  attr_accessible :nickname, :type

  def read_shape
    self.shape.html_safe
  end

  def update_shape
    populate_shape
  end

  private

    def test_html_existence
      return false unless nickname && File.exist?(filename = 'public/blocks/' + nickname + '.html')
      filename
    end

    def populate_shape
      filename = test_html_existence
      return unless filename
      f = File.open(filename)
      shape_html = ''
      f.each do |line|
        shape_html += line
      end
      self.shape = shape_html
    end

end