class Beer < ActiveRecord::Base
include Average




  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  
  validates :name, uniqueness: true
   validates :name, presence: true, length: {minimum: 3}
   
  
	
	def to_s
		return "#{self.name}";
	end
	
end
