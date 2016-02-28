class RatingsController < ApplicationController
 before_action :set_recent, only: [:index]

  def index
   @recent_ratings = Rating.recent
   @ratings = Rating.all
   @users = User.all
   @top_breweries = Brewery.top 3
   @top_users = User.top 3
   @top_beers = Beer.top 3
   #@top_styles = Style.top 3
  end
  
  def new
    @rating = Rating.new
	@beers = Beer.all
  end
  
    
  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end
  
    def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
  
  private
  
      def set_recent
	  Rating.all.each do |r|
	   r.recent=false
	   r.save
	  end
      s = Rating.last(5)
	  s.each do |r|
	   r.recent=true
	   r.save
	  end
	  
    end
  
end