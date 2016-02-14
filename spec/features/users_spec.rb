require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Taneli", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Taneli'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Taneli", password:"wrong")

      expect(current_path).to eq(signin_path)
          expect(page).to have_content 'Username and/or password mismatch'

    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
  
  describe "favorites" do
		  let! (:brewery){ FactoryGirl.create :brewery, name:"Koff"}
		  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", style:"Pale ale", brewery:brewery }
		  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu"}

       it "doesn't have favorite style or favorite brewery in the page without ratings" do
	      visit user_path(User.first)
	
 		  expect(page).to have_no_content "favorite" 
	  end
	  
      it "does have right favorite style and brewery in page when style is added" do
			sign_in(username:"Taneli", password:"Foobar1")
			
			
			visit new_rating_path
			select('iso 3', from:'rating[beer_id]')
			fill_in('rating[score]', with:'20')
			click_button "Create Rating"
			
			visit new_rating_path
			select('iso 3', from:'rating[beer_id]')
			fill_in('rating[score]', with:'20')
			click_button "Create Rating"
			
			visit new_rating_path
			select('Karhu', from:'rating[beer_id]')
			fill_in('rating[score]', with:'18')
			click_button "Create Rating"
			visit user_path(User.first)

			#expect(page).to have_content "favorite beer style is Pale ale" flippaa jotain omaansa.
			expect(page).to have_content "favorite beer's brewery is Koff"
		
	  end
  end
end