require 'spec_helper'

feature 'SessionsController' do

  let(:user) { FactoryBot.create(:user) }
  let(:new_user) { FactoryBot.build(:user) }
  let(:block) { FactoryBot.create(:block, nickname: 'submarine') }
  let(:solution) { FactoryBot.create(:solution, nickname: 'demo_solution') }
  let(:level1) { FactoryBot.create(:level, level_number: 1, blocks: [solution]) }

  describe '#new' do
    before(:each) do
      block
      solution
      visit root_path
      click_link('Load an Existing Account')
    end

    context 'with form fields filled correctly' do
      before(:each) do
        level1
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button('Done')
      end

      it 'redirects to the user\'s level-select page' do
        expect(page.body).to have_content("Welcome, #{user.name}!")
      end
    end

    context 'when the user does not exist' do
      before(:each) do
        fill_in 'Email', with: new_user.email
        fill_in 'Password', with: new_user.password
        click_button('Done')
      end

      it 'remains on the login page' do
        expect(page.body).to have_content("Sign In")
      end

      it 'displays the appropriate error message' do
        expect(page.body).to have_content("We don't have an account registered to that email address. Please try again.")
      end
    end

    context 'with incorrect password' do
      before(:each) do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'not_my_password'
        click_button('Done')
      end

      it 'remains on the login page' do
        expect(page.body).to have_content("Sign In")
      end

      it 'displays the appropriate error message' do
        expect(page.body).to have_content("Incorrect email/password combination. Please try again.")
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      block
      solution
      level1
      visit root_path
      click_link('Load an Existing Account')
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button('Done')
    end

    it 'returns the user to the main menu' do
      click_link('Sign Out')
      expect(page.body).to have_link('Load an Existing Account')
      expect(page.body).to have_link('Create a New Account')
    end
  end
end
