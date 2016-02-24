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
	
end
