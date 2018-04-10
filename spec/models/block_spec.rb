require 'spec_helper'

describe Block, type: :model do
  it { should have_and_belong_to_many :levels }
  it { should validate_presence_of :nickname }
  it { should validate_uniqueness_of :nickname }
  it { should validate_presence_of :shape }

  let(:block) { FactoryBot.create(:block, nickname: 't_block') }

  context 'without a nickname that corresponds to a local html file' do
    it 'should not be valid' do
      expect(FactoryBot.build(:block, nickname: 'nonexistent')).not_to be_valid
    end
  end

  context 'with a nickname that corresponds to a local html file' do
    it 'should be valid' do
      expect(FactoryBot.build(:block, nickname: 't_block')).to be_valid
    end

    describe '#shape' do
      it 'should be populated with the content of the appropriate HTML file' do
        f = File.open('public/blocks/t_block.html')
        str = ''
        f.each { |line| str += line }
        expect(block.shape).to eq str
      end
    end
  end

end

describe Solution do
  let(:solution) { FactoryBot.create(:solution) }

  it 'should inherit from Block' do
    expect(solution.class.superclass).to be Block
  end
end
