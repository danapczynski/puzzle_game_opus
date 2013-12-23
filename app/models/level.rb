class Level < ActiveRecord::Base
  has_many :scores
  has_many :users, through: :scores
  has_and_belongs_to_many :blocks
  attr_accessible :level_number
  validates :level_number, presence: true

  def associate_blocks(nicknames_array)
    nicknames_array.each do |nick|
      self.blocks << Block.find_by_nickname(nick)
    end
  end

  def solution
    solutions[0]
  end

  def playable_blocks
    @playable ||= self.blocks.where(type: nil)
  end

  private

    def solutions
      @solutions ||= self.blocks.where(type: 'Solution')
    end
end