class GenerateRestaurantJob < ApplicationJob
  queue_as :default

  def perform(chomp_session_id)
    chomp_session = ChompSession.find(chomp_session_id)
    if chomp_session.status == "pending"
      if chomp_session.responses == []
        restaurant = Restaurant.all.sample
      else
        restaurant = generate_restaurant(chomp_session).first 
        restaurant = Restaurant.all.sample if restaurant.nil?
      end
      chomp_session.restaurant = restaurant
      chomp_session.status = "closed"
      chomp_session.save
    end
    responses_arr = chomp_session.responses
    responses_arr.each do |response|
      next if response.user.nil?

      RestaurantResultMailer.with(restaurant: restaurant, chomp_session: chomp_session, response: response).result_release.deliver_later
    end
  end

  private

  def generate_restaurant(chomp_session)
    # algorithm to get recommendation
    # based on chompsession ID, get all responses
    # find the lowest budget, convert to integer 1,2,3 or 4
    # get frequency table of cuisines. Get the highest frequency cuisinse.
    # If no highest frequency
    # Get middleground of all location responses and get the highest rated restaurant with the specified cuisine.
    responses = chomp_session.responses
    lowest_budget = responses.minimum('budget')
    restaurant_pricing = determine_pricing(lowest_budget.to_i)

    cuisine_arr = []
    responses.each do |response|
      response_cuisine = response.cuisine
      cuisine_arr << response_cuisine.slice!(1, response_cuisine.length) unless response_cuisine == [""]
    end
    cuisine_arr.flatten!(1)
    tallied_result = cuisine_arr.tally
    most_frequent_cuisine_kv = tallied_result.max_by { |_, value| value }

    # check tie
    tied_results = tallied_result.select { |_, v| v == most_frequent_cuisine_kv[1] }
    if tied_results.length == 1
      result_cuisine = most_frequent_cuisine_kv[0]
      # num_votes = most_frequent_cuisine_kv[1]
    else
      result_cuisine = tied_results.keys.sample
    end

    # location
    geographic_center = Geocoder::Calculations.geographic_center(responses)

    # restaurant within 5km of center ordered by rating and budget
    restaurant = Restaurant.where("pricing = ?", restaurant_pricing).cuisine_type(result_cuisine).near(geographic_center, 5).reorder('google_rating desc').limit(1)

    if restaurant.empty?
      restaurant = Restaurant.where("pricing = ?", restaurant_pricing).cuisine_type(result_cuisine).reorder('google_rating desc').limit(1)
    end
    return restaurant
  end

  def determine_pricing(budget)
    if budget > 50
      4
    elsif budget > 25
      3
    elsif budget > 10
      2
    else
      1
    end
  end
end
