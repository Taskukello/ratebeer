require 'rails_helper'
require 'securerandom'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end
  
    it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"Se2", password_confirmation:"Se2"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

    it "is empty at start" do
    expect(User.count).to eq(0)
  end

  
  it "is not saved with password only containing characters" do
    user = User.create username:"Pekka", password:"OlenLause", password_confirmation:"OlenLause"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  
 describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

  end

end # describe User

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating user, score
  end
end

def create_beer_with_rating(user, score)

  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end

  
end