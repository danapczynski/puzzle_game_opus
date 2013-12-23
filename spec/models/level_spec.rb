require 'spec_helper'

describe Level do
  it { should have_many :scores }
  it { should have_many :users }
  it { should have_and_belong_to_many :blocks }
  
  let(:level1) { FactoryGirl.create(:level, id: 1) }
  let(:user)   { FactoryGirl.create(:user) }

  describe '#users' do
    context 'before being completed by any users' do
      it 'should return an empty array' do
        expect(level1.users).to eq []
      end
    end

    context 'after being completed by a user' do
      before(:each) do
        level1.scores << FactoryGirl.create(:score, user: user, level: level1)
      end

      it 'returns an array containing the user' do
        expect(level1.users).to include user
      end

      context '(several times)' do
        before(:each) do
          10.times { level1.scores << FactoryGirl.create(:score, user_id: 1, level: level1) }
        end

        it 'should count that user only once' do
          expect(level1.users.length).to be 1
        end
      end
    end

    context 'after being completed by different users' do
      before(:each) do
        4.times { level1.scores << FactoryGirl.create(:score, level: level1) }
      end

      it 'returns an array with length equal to the number of completing users' do
        expect(level1.users.length).to be 4
      end
    end
  end
end