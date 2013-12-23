LEVELS = {
  1 => ['solution1', 't_block', 'submarine', 'l_block']
}

class LevelSeed
  def self.populate(n)
    1.upto(n) do |index| 
      level = Level.new(level_number: index) 
      level.associate_blocks(LEVELS[index])
      level.save!
    end
  end
end

class BlockSeed
  def self.populate
    Block.create(nickname: 't_block')
    Block.create(nickname: 'submarine')
    Block.create(nickname: 'l_block')
    Solution.create(nickname: 'solution1')
  end
end

# Create blocks
BlockSeed.populate

# Set the number of levels
LevelSeed.populate(1)

