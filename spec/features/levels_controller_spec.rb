require 'spec_helper'

feature 'LevelsController' do
  let(:user)      { FactoryGirl.create(:user) }
  let(:block)     { FactoryGirl.create(:block) }
  let(:solution1) { FactoryGirl.create(:solution, nickname: 'solution1') }
  let(:solution2) { FactoryGirl.create(:solution, nickname: 'solution2') }
  let(:level1)    { FactoryGirl.create(:level, level_number: 1) }
  let(:level2)    { FactoryGirl.create(:level, level_number: 2) }

  describe '#show' do
    context 'when user is not logged in' do
      it 'redirects user to the main menu' do
        visit level_path(level1)
        expect(page.body).to have_link("Create a New Account")
        expect(page.body).to have_link("Load an Existing Account")
      end
    end

    context 'with logged in user' do
      before(:each) do
        login(user)
        level1.associate_blocks([solution1.nickname, block.nickname])
        level2.associate_blocks([solution2.nickname, block.nickname])
      end

      it 'allows user to visit first level' do
        visit level_path(level1)
        expect(page.body).to have_content('Level 1')
        expect(page.body).to have_css('table#solution')
      end

      context 'when user has access to the level' do
        it 'displays the level' do
          FactoryGirl.create(:score, level_id: level1.id, user_id: user.id)
          visit level_path(level2)
          expect(page.body).to have_content('Level 2')
          expect(page.body).to have_css('table#solution')
        end
      end

      context 'when user does not have access to the level' do
        it 'redirects to user_path(user)' do
          visit level_path(level2)
          expect(page.body).to have_content("Welcome, #{user.name}!")
        end
      end

      context 'when level does not exist' do
        it 'redirects to user_path(user)' do
          visit level_path(FactoryGirl.build(:level, level_number: 3))
          expect(page.body).to have_content("Welcome, #{user.name}!")
        end
      end
    end
  end
end