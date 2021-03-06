class Beer < ActiveRecord::Base
include Average




  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  
   validates :name, presence: true, length: {minimum: 3}
   validates :style, presence: true
   
   
  
	
	def to_s
		return "#{self.name}";
	end
	
	
	   def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n);
  end
end
