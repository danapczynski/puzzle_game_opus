class LevelSeed
  def self.populate(n)
    n.times { Level.create }
    self.associate_blocks
  end

  def self.associate_blocks
    self.level_blocks(1, ['t_block'])
  end

  private

    def self.level_blocks(level_id, nicknames_array)
      level = Level.find(level_id)
      nicknames_array.each { |nick| level.blocks << Block.find_by_nickname(nick) }
    end
end

class BlockSeed
  def self.populate
    Block.create(nickname: 't_block')
    Block.create(nickname: 'submarine')
    # Block.create(nickname: , link_to_shape: )
    # Block.create(nickname: , link_to_shape: )
  end
end

# Create blocks
BlockSeed.populate

# Set the number of levels
LevelSeed.populate(10)

