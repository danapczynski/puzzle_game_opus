require 'spec_helper'

feature 'StaticPagesController' do
  let(:user) { FactoryGirl.create(:user) }

  describe '#index' do
    before(:each) do
      visit root_path
    end

    context 'when the user is not logged in' do
      it 'displays the main menu' do
        expect(page.body).to have_link('Load an Existing Account')
        expect(page.body).to have_link('Create a New Account')
      end

      describe 'Create a New Account link' do
        before(:each) do
          click_link('Create a New Account')
        end

        it 'visits Users#new' do
          expect(page.body).to have_content('Create a User')
        end

        describe 'Go Back link' do
          it 'returns user to the main menu' do
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

        it 'visits Sessions#new' do
          expect(page.body).to have_content('Sign In')
        end

        describe 'Go Back link' do
          it 'returns user to the main menu' do
            click_link('Go Back')
            expect(page.body).to have_link('Load an Existing Account')
            expect(page.body).to have_link('Create a New Account')
          end
        end
      end
    end

    context 'when the user is logged in' do
      it 'redirects to Users#show' do
        login(user)
        visit root_path
        expect(page.body).to have_content("Welcome, #{user.name}!")
      end
    end
  end

  describe 'About GameBoy Opus link' do
    before(:each) do
      visit root_path
      click_link('About GameBoy Opus')
    end

    it 'navigates to StaticPages#about' do
      expect(page.body).to have_content("About This Game")
    end

    describe 'Go Back link' do
      it 'returns user to the main menu' do
        click_link('Go Back')
        expect(page.body).to have_link('Load an Existing Account')
        expect(page.body).to have_link('Create a New Account')
      end
    end
  end
end