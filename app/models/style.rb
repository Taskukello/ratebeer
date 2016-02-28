class Style < ActiveRecord::Base
include Average
  has_many :beers
  
  
  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n);
  end
end