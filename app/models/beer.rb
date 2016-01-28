class Beer < ActiveRecord::Base
include Average
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  
	
	def to_s
		return "#{self.name}";
	end
end
