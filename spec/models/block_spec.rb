require 'spec_helper'

describe Block do
  it { should have_and_belong_to_many :levels }
  it { should validate_presence_of :nickname }
  it { should validate_presence_of :shape }

  let(:block) { FactoryGirl.create(:block) }

  context 'without a nickname that corresponds to a local html file' do
    it 'should not be valid' do
      expect(FactoryGirl.build(:block, nickname: 'nonexistent')).not_to be_valid
    end
  end

  context 'with a nickname that corresponds to a local html file' do
    it 'should be valid' do
      expect(FactoryGirl.build(:block, nickname: 't_block')).to be_valid
    end
  end
  
end