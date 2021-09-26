class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    
    @geojson = {
            type: 'Restaurant',
            geometry: {
              type: 'Point',
              coordinates: [@restaurant.longitude, @restaurant.latitude]
            },
            properties: {
              name: @restaurant.name,
              address: @restaurant.address,
              :'marker-color' => '#00607d',
              :'marker-symbol' => 'circle',
              :'marker-size' => 'medium'
            }
          }

    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end
end
