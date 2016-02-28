class Brewery < ActiveRecord::Base
include Average
has_many :beers,  dependent: :destroy
has_many :ratings, through: :beers


validates :name, uniqueness: true
validates :year, numericality: {greater_than_or_equal_to: 1042,
								 only_integer: true}
								 
  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }								 
								 
 validates :name, presence: true, length: {minimum: 3}
   validate :validate_year

  def validate_year
    errors.add :year, " can't be in the future" if year > Time.now.year.to_i
  end
 

    def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end
  
    def restart
    self.year = 2016
    puts "changed year to #{year}"
  end
  
  
 def self.top(n)
   sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
   return sorted_by_rating_in_desc_order.take(n)
end

  def to_s
  return "#{self.name}";
  end
end
