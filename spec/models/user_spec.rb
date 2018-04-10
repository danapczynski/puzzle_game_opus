require 'spec_helper'

describe User, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :scores }
  it { should have_many :levels }

  let(:user) { FactoryBot.create(:user) }

  context 'when first initialized' do
    describe '#new_player?' do
      it 'should return true' do
        expect(user.new_player?).to be true
      end
    end

    describe '#last_level_completed' do
      it 'should return nil' do
        expect(user.last_level_completed).to be nil
      end
    end
  end

  context 'after completing a level' do
    before(:each) do
      FactoryBot.create(:score, user: user, level: (FactoryBot.create(:level)))
    end

    describe '#new_player?' do
      it 'should return false' do
        expect(user.new_player?).to be false
      end
    end

    describe '#last_level_completed' do
      it 'should return a Level object' do
        expect(user.last_level_completed).to be_an_instance_of Level
      end

      it 'should return the completed level' do
        expect(user.last_level_completed).to eq Level.find_by_level_number(1)
      end
    end

    describe '#next_level' do
      before(:each) do
        FactoryBot.create(:level, level_number: 2)
      end

      it 'should return a Level object' do
        expect(user.next_level).to be_an_instance_of Level
      end

      it 'should return a level the user has not yet completed' do
        expect(user.next_level.users).not_to include user
      end
    end
  end

end
