class ReviewsController < ApplicationController
  def create
    # Creating new review
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    @review.user = current_user

    # Updating restaurant's average rating with new review rating
    count_rating(@restaurant, @review)
    if @review.save

      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant, anchor: "review-#{@review.id}") }
        format.json
      end
    else
      respond_to do |format|
        format.html { render 'restaurants/show' }
        format.json
        end
    end
  end


  private

  def count_rating(restaurant_instance, review_instance)
    sum_of_rating = 0
    restaurant_instance.reviews.each { |review| sum_of_rating += review.rating }
    new_rating = review_instance.rating
    rating_count = restaurant_instance.reviews.count
    # If the restaurant has 0 ratings so far, let the 1st rating be the new rating
    new_average_rating = rating_count.zero? ? new_rating : (sum_of_rating + new_rating).fdiv(rating_count + 1)
    restaurant_instance.average_rating = new_average_rating
    restaurant_instance.save
  end

  def review_params
    params.require(:review).permit(:rating, :title, :content)
  end
end
