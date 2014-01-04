LEVELS = {
  1 => ['solution1', 't_block', 'submarine', 'l_block'],
  2 => ['solution2', 't_block', 'submarine', 'l_block', 'utah'],
  3 => ['solution3', 't_block', 'submarine', 'l_block', 'utah', 'straight_block'],
  4 => ['solution4', 't_block', 'submarine', 'l_block', 'utah', 'straight_block', 'corner'],
  5 => ['solution5', 't_block', 'submarine', 'l_block', 'utah', 'straight_block', 'corner', 'c_block'],
  6 => ['solution6', 't_block', 'submarine', 'l_block', 'utah', 'straight_block', 'corner', 'c_block', 'crooked'],
  7 => ['solution7', 't_block', 'submarine', 'l_block', 'utah', 'straight_block', 'corner', 'c_block', 'crooked', 'plus']
}

class LevelSeed
  def self.populate(n)
    1.upto(n) do |index| 
      level = Level.new(level_number: index) 
      level.associate_blocks(LEVELS[index])
      level.save
    end
  end
end

class BlockSeed
  def self.populate
    Solution.create(nickname: 'demo_solution')
    Block.create(nickname: 't_block')
    Block.create(nickname: 'submarine')
    Block.create(nickname: 'l_block')
    Solution.create(nickname: 'solution1')
    Block.create(nickname: 'utah')
    Solution.create(nickname: 'solution2')
    Block.create(nickname: 'straight_block')
    Solution.create(nickname: 'solution3')
    Block.create(nickname: 'corner')
    Solution.create(nickname: 'solution4')
    Block.create(nickname: 'c_block')
    Solution.create(nickname: 'solution5')
    Block.create(nickname: 'crooked')
    Solution.create(nickname: 'solution6')
    Block.create(nickname: 'plus')
    Solution.create(nickname: 'solution7')
  end

  def self.update_shapes
    Block.all.each do |block| 
      block.update_shape
      block.save
    end
  end
end

# Create blocks
BlockSeed.populate
BlockSeed.update_shapes

# Set the number of levels
LevelSeed.populate(7)

