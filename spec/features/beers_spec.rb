require 'rails_helper'

include Helpers


describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }
  
    before :each do
    sign_in(username:"Taneli", password:"Foobar1")
  end
  
  
    it "when created, is saved to the system." do
    visit new_beer_path
    fill_in('beer[name]', with:'keisari')  #sivu pakottaa käyttäjän syöttämään panimon nimi, ja tyylin.

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end
  
  
    it "when created with too short name, its not saved to the system." do
    visit new_beer_path
    fill_in('beer[name]', with:'ka')


    click_button "Create Beer"
    expect(page).to have_content 'Name is too short (minimum is 3 characters)'
  end
  
    it "when created without name, its not saved to the system" do
		    visit new_beer_path
			fill_in('beer[name]', with:'')


    click_button "Create Beer"
        expect(page).to have_content 'Name is too short (minimum is 3 characters)'
	
	end 

end