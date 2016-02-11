require 'rails_helper'

RSpec.describe Beer, type: :model do


    it "is valid and saved" do
	beer = Beer.create name:"testiolut", style:"Lager", brewery_id: 1
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
	
	
	it "is not valid with empty as name" do
		beer = Beer.create name:"" , style:"Lager", brewery_id: 1
       expect(beer).not_to be_valid
       expect(Beer.count).to eq(0)
    end
  
	it "is not valid without name long enough" do
		beer = Beer.create name:"ka" , style:"Lager", brewery_id: 1
       expect(beer).not_to be_valid
       expect(Beer.count).to eq(0)
    end 

    it "is not valid without style" do
		beer = Beer.create name:"kacake" , style:"", brewery_id: 1
       expect(beer).not_to be_valid
       expect(Beer.count).to eq(0)
    end 
  
end
