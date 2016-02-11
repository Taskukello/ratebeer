require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Taneli", password:"Foobar1")
  end
  
  
  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  

  it "shows ratings in user page" do
	
	visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"
	
	visit user_path(user)
	
	expect(page).to have_content "has 1 rating"
	expect(page).to have_content "iso 3 15"
	
	visit new_rating_path
	
	   select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'10')
    click_button "Create Rating"
	
		expect(page).to have_content "has 2 ratings"
	expect(page).to have_content "iso 3 15"
		expect(page).to have_content "Karhu 10"
	
	
  end
  
    it "removes rating from system" do  #ratingin luonti ei ole describe metodissa koska se ei jostain syystä toiminut testeissä vaikka se kyllä loi asiat.

   
   	visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"
	
	visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'10')
    click_button "Create Rating"
	
	
	visit user_path(user)
	
	within(page.find('li', :text => 'Karhu')) do
	click_on("delete")
	end
	
		expect(page).to have_content "has 1 rating"
	expect(page).to have_content "iso 3 15"
		expect(page).to have_no_content "Karhu 10"
	
	
  end
  

end