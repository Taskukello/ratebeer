class User < ActiveRecord::Base
include Average

helpHash = Hash.new
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
  
  
    def favorite_style

    return nil if ratings.empty?
    return ratings.first.beer.style if ratings.count == 1

    weizens = ratings.find_all {|r| r.beer.style == "Weizen"}
    lagers= ratings.find_all {|r| r.beer.style == "Lager"}
    paleales = ratings.find_all {|r| r.beer.style == "Pale Ale"}
    ipas = ratings.find_all {|r| r.beer.style == "IPA"}
    porters = ratings.find_all {|r| r.beer.style == "Porter"}

	
	
    beers = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
    values = [
        (weizens.inject(0.0) {|sum,rating| sum + rating[:score]} / (weizens.size + 0.00000001)).round(2),
        (lagers.inject(0.0) {|sum,rating| sum + rating[:score]} / (lagers.size + 0.0000001)).round(2),
        (paleales.inject(0.0) {|sum,rating| sum + rating[:score]} / (paleales.size  + 0.00000001)).round(2),
        (ipas.inject(0.0) {|sum,rating| sum + rating[:score]} / (ipas.size  + 0.00000001)).round(2),
        (porters.inject(0.0) {|sum,rating| sum + rating[:score]} / (porters.size  + 0.00000001)).round(2),
    ]

    return beers[values.index(values.max)]

  end
  
  
  def favorite_brewery
	return nil if ratings.empty?
	ratings.order(score: :desc).limit(1).first.beer.brewery
	
	
  end
end




class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating kuuluu myös käyttäjään

  def to_s
    "#{beer.name} #{score}"
  end
end