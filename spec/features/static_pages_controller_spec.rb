require 'spec_helper'

feature 'StaticPagesController' do
  let(:user) { FactoryGirl.create(:user) }

  describe '#index' do
    before(:each) do
      visit root_path
    end

    context 'when the user is not logged in' do
      it 'should take user to the main menu' do
        expect(page.body).to have_link('Load an Existing Account')
        expect(page.body).to have_link('Create a New Account')
      end

      describe 'Create a New Account link' do
        before(:each) do
          click_link('Create a New Account')
        end

        it 'should take user to new user form' do
          expect(page.body).to have_content('Create a User')
        end

        describe 'Go Back link' do
          it 'should return user to the main menu' do
            click_link('Go Back')
            expect(page.body).to have_link('Load an Existing Account')
            expect(page.body).to have_link('Create a New Account')
          end
        end
      end

      describe 'Load an Existing Account link' do
        before(:each) do
          click_link('Load an Existing Account')
        end

        it 'should take user to existing user login form' do
          expect(page.body).to have_content('Sign In')
        end

        describe 'Go Back link' do
          it 'should return user to the main menu' do
            click_link('Go Back')
            expect(page.body).to have_link('Load an Existing Account')
            expect(page.body).to have_link('Create a New Account')
          end
        end
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