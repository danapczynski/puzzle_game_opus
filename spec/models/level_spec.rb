require 'spec_helper'

describe Level, type: :model do
  it { should have_many :scores }
  it { should have_many :users }
  it { should validate_presence_of :level_number }
  it { should validate_uniqueness_of :level_number }
  it { should have_and_belong_to_many :blocks }

  let(:level1)   { FactoryBot.create(:level, level_number: 1, id: 1) }
  let(:level2)   { FactoryBot.create(:level, level_number: 2, id: 2) }
  let(:user)     { FactoryBot.create(:user) }
  let(:block)    { FactoryBot.create(:block) }
  let(:block2)   { FactoryBot.create(:block, nickname: 'l_block') }
  let(:block3)   { FactoryBot.create(:block, nickname: 'submarine') }
  let(:solution) { FactoryBot.create(:solution) }

  describe '#users' do
    context 'before being completed by any users' do
      it 'should return an empty array' do
        expect(level1.users).to eq []
      end
    end

    context 'after being completed by a user' do
      before(:each) do
        level1.scores << FactoryBot.create(:score, user: user, level: level1)
      end

      it 'returns an array containing the user' do
        expect(level1.users).to include user
      end

      context '(several times)' do
        before(:each) do
          10.times { level1.scores << FactoryBot.create(:score, user_id: 1, level: level1) }
        end

        it 'should count that user only once' do
          expect(level1.users.length).to be 1
        end
      end
    end

    context 'after being completed by different users' do
      before(:each) do
        4.times { level1.scores << FactoryBot.create(:score, level: level1) }
      end

      it 'returns an array with length equal to the number of completing users' do
        expect(level1.users.length).to be 4
      end
    end
  end

  describe '#next' do
    it 'returns the level with the next-highest level_number' do
      level2
      expect(level1.next).to eq level2
    end

    context 'when there is no next level' do
      it 'returns nil' do
        expect(level2.next).to be_nil
      end
    end
  end

  describe '#associate_blocks' do
    before(:each) do
      level1.associate_blocks([solution.nickname, block.nickname])
    end

    it 'adds specified blocks to Level#blocks array' do
      expect(level1.blocks).to include block
      expect(level1.blocks).to include solution
    end

    it 'raises an error if multiple solutions are added' do
      level1.associate_blocks([FactoryBot.create(:solution, nickname: 'solution2').nickname])
      expect{ level1.save! }.to raise_error
    end
  end

  describe '#solution' do
    it 'returns the associated Solution object' do
      level1.associate_blocks([solution.nickname, block.nickname])
      expect(level1.solution).to eq solution
    end

    context 'when no solution has been associated' do
      it 'returns nil' do
        expect(level1.solution).to be_nil
      end
    end
  end

  describe '#playable_blocks' do
    before(:each) do
      level1.associate_blocks([block.nickname, block2.nickname, block3.nickname, solution.nickname])
    end

    it 'returns an array containing all Block objects' do
      expect(level1.playable_blocks).to include block
      expect(level1.playable_blocks).to include block2
      expect(level1.playable_blocks).to include block3
      expect(level1.playable_blocks.length).to be 3
    end

    it 'should not return solution' do
      expect(level1.playable_blocks).not_to include solution
    end
  end
end
