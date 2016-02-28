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

    rated = ratings.map{ |r| r.beer.style }.uniq
   return rated.sort_by { |style| -rating_of_style(style) }.first
  end

    def rating_of_style(style)
    ratings_of = ratings.select{ |r| r.beer.style==style }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end
  
  def favorite_brewery
	return nil if ratings.empty?
	ratings.order(score: :desc).limit(1).first.beer.brewery
	
	
  end
  
    def self.top(n)
    sorted_by_rating_count = User.all.sort_by{ |u| -(u.ratings.count||0) }
    return sorted_by_rating_count.take(n);
  end
end
