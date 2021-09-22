if @review.persisted?
  json.form json.partial!('reviews/form.html.erb', restaurant: @restaurant, review: Review.new)
  json.inserted_item json.partial!('restaurants/review.html.erb', review: @review)
else
  json.form json.partial!('reviews/form.html.erb', restaurant: @restaurant, review: @review)
end
