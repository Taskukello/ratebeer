class PlacesController < ApplicationController
before_action :set_place, only: [:show]
  def index
  end
  


  def search
    @places = BeermappingApi.places_in(params[:city])
    if(@places.empty?)
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = params[:city]
      render :index
    end
  end
        def set_place
    @place = BeermappingApi.get_place(session[:city], params[:id])
  end

end