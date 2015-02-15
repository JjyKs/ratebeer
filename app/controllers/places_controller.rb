class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingApi.fetch_place_by(params[:id]).first()
    if @place.nil?
      redirect_to places_path, notice: "Unknown error occurred"
    else
      render :show
    end
  end
end