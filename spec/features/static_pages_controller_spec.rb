require 'spec_helper'

feature 'StaticPages' do
  let(:user) { FactoryGirl.create(:user) }

  describe 'index' do
    context 'when the user is not logged in' do
      it 'should take user to the main menu' do
        visit root_path
        expect(page.body).to have_link("Create a New Account")
      end
    end

    context 'when the user is logged in' do
      it 'should redirect to Users#show' do
        login(user)
        visit root_path
        expect(page.body).to have_content("Welcome, #{user.name}!")
      end
    end
  end
end