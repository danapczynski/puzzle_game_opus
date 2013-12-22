require 'spec_helper'

describe User do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :scores }
  it { should have_many :levels }

  let(:user) { FactoryGirl.create(:user) }

  context 'when first initialized' do
    describe '#new_player?' do
      it 'should return true' do
        expect(user.new_player?).to be true
      end
    end
  end

  context 'after completing a level' do
    before(:each) do
      FactoryGirl.create(:score, user: user)
    end

    describe '#new_player?' do
      it 'should return false' do
        expect(user.new_player?).to be false
      end
    end
  end

end