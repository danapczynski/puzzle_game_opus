require 'spec_helper'

feature 'UsersController' do
  let(:user) { FactoryGirl.create(:user) }
  let(:new_user) { FactoryGirl.build(:user, name: 'Some_Other_Name') }
  let(:block) { FactoryGirl.create(:block, nickname: 'submarine') }
  let(:solution) { FactoryGirl.create(:solution, nickname: 'demo_solution') }
  let(:level) { FactoryGirl.create(:level, blocks: [block, solution]) }

  describe '#show' do
    context 'when the user is not logged in' do
      it 'should redirect to the main menu' do
        block
        solution
        visit user_path(user)
        expect(page.body).to have_link("Create a New Account")
        expect(page.body).to have_link("Load an Existing Account")
      end
    end

    context 'when the user is logged in' do
      before(:each) do
        level
        login(user)
        visit user_path(user)
      end

      it 'takes user to level-selection screen' do
        expect(page.body).to have_content("Welcome, #{user.name}!")
      end

      context 'when user attempts to access another user\'s #show page' do
        it 'redirects to the user\'s own #show page' do
          new_user.save
          visit user_path(new_user)
          expect(page.body).not_to have_content(new_user.name)
          expect(page.body).to have_content(user.name)
        end
      end

      context 'when user has not completed any levels' do
        it 'features link to start a new game' do
          expect(page.body).to have_link('Start a New Game')
        end
      end

      context 'when user has completed a level' do
        before(:each) do
          FactoryGirl.create(:score, user: user, level: level)
          visit user_path(user)
        end

        it 'features link to replay that level' do
          expect(page.body).to have_link("Level #{level.level_number}")
        end

        context 'when there are additional levels that have not been completed' do
          before(:each) do
            FactoryGirl.create(:level, level_number: 2, blocks: [FactoryGirl.create(:block), FactoryGirl.create(:solution)] )
            visit user_path(user)
          end

          it 'features a link to continue the game' do
            expect(page.body).to have_link('Continue Your Game') 
          end

          describe '"Continue Your Game" link' do
            it 'takes user to the next unfinished level' do
              click_link 'Continue Your Game'
              expect(page.body).to have_content("Level #{user.next_level.level_number}")
            end
          end
        end
      end
    end
  end

  describe '#new' do
    before(:each) do
      block
      solution
      visit root_path
      click_link('Create a New Account')
    end

    context 'with fields filled correctly' do
      before(:each) do
        level
        fill_in 'Name', with: new_user.name
        fill_in 'Email', with: new_user.email
        fill_in 'Password', with: new_user.password
        fill_in 'Confirm Password', with: new_user.password
      end

      it 'creates a new user' do
        expect{ click_button('Done') }.to change{ User.count }
      end

      it 'redirects to the user\'s level-select page' do
        click_button('Done')
        expect(page.body).to have_content("Welcome, #{new_user.name}!")
      end
    end

    context 'with name left blank' do
      before(:each) do
        fill_in 'Email', with: new_user.email
        fill_in 'Password', with: new_user.password
        fill_in 'Confirm Password', with: new_user.password
      end

      it 'does not create a new user' do
        expect{ click_button('Done') }.not_to change { User.count }
      end

      it 'remains on the user creation page' do
        click_button('Done')
        expect(page.body).to have_content('Create a User')
      end
         
      it 'displays the appropriate error message' do
        click_button('Done')
        expect(page.body).to have_content('Name can\'t be blank')
      end 
    end

    context 'with email left blank' do
      before(:each) do
        fill_in 'Name', with: new_user.name
        fill_in 'Password', with: new_user.password
        fill_in 'Confirm Password', with: new_user.password
      end

      it 'does not create a new user' do
        expect{ click_button('Done') }.not_to change { User.count }
      end

      it 'remains on the user creation page' do
        click_button('Done')
        expect(page.body).to have_content('Create a User')
      end
         
      it 'displays the appropriate error message' do
        click_button('Done')
        expect(page.body).to have_content('Email can\'t be blank')
      end 
    end

    context 'with password left blank' do
      before(:each) do
        fill_in 'Name', with: new_user.name
        fill_in 'Email', with: new_user.email
      end

      it 'does not create a new user' do
        expect{ click_button('Done') }.not_to change { User.count }
      end

      it 'remains on the user creation page' do
        click_button('Done')
        expect(page.body).to have_content('Create a User')
      end
         
      it 'displays the appropriate error message' do
        click_button('Done')
        expect(page.body).to have_content('Password can\'t be blank')
      end 
    end

    context 'with email that already exists' do
      before(:each) do
        FactoryGirl.create(:user, email: new_user.email)
        fill_in 'Name', with: new_user.name
        fill_in 'Email', with: new_user.email
        fill_in 'Password', with: new_user.password
        fill_in 'Confirm Password', with: new_user.password
      end

      it 'does not create a new user' do
        expect{ click_button('Done') }.not_to change { User.count }
      end

      it 'remains on the user creation page' do
        click_button('Done')
        expect(page.body).to have_content('Create a User')
      end
         
      it 'displays the appropriate error message' do
        click_button('Done')
        expect(page.body).to have_content('Email has already been taken')
      end 
    end

    context 'with improperly formatted email address' do
      before(:each) do
        new_user = FactoryGirl.build(:user, email: 'not_an_email')
        fill_in 'Name', with: new_user.name
        fill_in 'Email', with: new_user.email
        fill_in 'Password', with: new_user.password
        fill_in 'Confirm Password', with: new_user.password
      end

      it 'does not create a new user' do
        expect{ click_button('Done') }.not_to change { User.count }
      end

      it 'remains on the user creation page' do
        click_button('Done')
        expect(page.body).to have_content('Create a User')
      end
         
      it 'displays the appropriate error message' do
        click_button('Done')
        expect(page.body).to have_content('Email is not formatted correctly')
      end 
    end

    context 'when password confirmation does not match' do
      before(:each) do
        fill_in 'Name', with: new_user.name
        fill_in 'Email', with: new_user.email
        fill_in 'Password', with: new_user.password
        fill_in 'Confirm Password', with: 'not_my_password'
      end

      it 'does not create a new user' do
        expect{ click_button('Done') }.not_to change { User.count }
      end

      it 'remains on the user creation page' do
        click_button('Done')
        expect(page.body).to have_content('Create a User')
      end
         
      it 'displays the appropriate error message' do
        click_button('Done')
        expect(page.body).to have_content('Password doesn\'t match confirmation')
      end 
    end
  end
end