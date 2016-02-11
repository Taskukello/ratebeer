class User < ActiveRecord::Base
include Average

PASSWORD_FORMAT = /\A
  (?=.*\d)           # Must contain a digit
  (?=.*[A-Z])        # Must contain an upper case character
/x

   validates :username, uniqueness: true
    validates :username, length: { minimum: 3,
									maximum: 15}
    validates :password,    :presence => true,
							length: {minimum: 4},
						    format: {with: PASSWORD_FORMAT,
							message: "password must include at least one upper char, and digit"}
							
	 
	 
   has_secure_password
   has_many :ratings,  dependent: :destroy
   has_many :beers, through: :ratings
   has_many :memberships,  dependent: :destroy
   has_many :beer_clubs, through: :memberships
  
  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
end



class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating kuuluu myös käyttäjään

  def to_s
    "#{beer.name} #{score}"
  end
end