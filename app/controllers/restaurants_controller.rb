class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: :toggle_favorite

  def index
    @restaurants = Restaurant.all
    @favorite_restaurants = current_user.favorited_by_type('Restaurant')
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @user = current_user
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end

  def toggle_favorite
    @restaurant = Restaurant.find(params[:id])
    current_user.favorited?(@restaurant) ? current_user.unfavorite(@restaurant) : current_user.favorite(@restaurant)
    current_user.save
    redirect_to restaurant_path(@restaurant)
  end
end
