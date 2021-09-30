require 'open-uri'
require "image_processing/mini_magick"

apikey = ENV['STB_API_KEY']
time_start= Time.now
puts "Clearing restaurants db"
Response.destroy_all
ChompSession.destroy_all
Restaurant.destroy_all
puts "Seeding db with restaurants"
cuisine_arr = %w[Asian Chinese Western Japanese Italian Halal Indian Thai Korean Local Steamboat Desserts]
# client = Pexels::Client.new
cuisine_arr.each do |cuisine|
  puts "--- searching #{cuisine} --- "
  url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&keyword=#{cuisine}&filtersource=stb&sortBy=rating&sortOrder=desc&language=en&apikey=#{apikey}"
  restaurant_counter = 0
  loop do
    fnb_serialized = URI.open(url).read
    fnb_parsed = JSON.parse(fnb_serialized)
    next_token = fnb_parsed["nextToken"]
    price = 1
    length_of_results = fnb_parsed["data"]["results"].length
    length_of_results.times do |index|
      restaurant = fnb_parsed["data"]["results"][index]
      next if restaurant["images"].empty?

      address = restaurant["address"]
      full_address = "
      #{address['block']}
      #{address['streetName']}
      #{address['floorNumber']}-#{address['unitNumber']}
      #{address['buildingName']} #{address['postalCode']}, Singapore"
      time = restaurant["businessHour"]
      if time.empty?
        opening_time = ["10:00", "10:30", "11:00"].sample
        closing_time = ["22:00", "22:30", "23:00"].sample
      else
        opening_time = time.first["openTime"]
        closing_time = time.first["closeTime"]
      end

      if restaurant["officialWebsite"].empty? || restaurant["officialWebsite"] == /hungrygowhere\.com/
        website = "https://www.google.com/search?q=#{restaurant['name']}"
      else
        website = restaurant["officialWebsite"]
      end
      # take the first thumbnail provided, if any
      restaurant_instance = Restaurant.new(
        name: restaurant["name"],
        address: full_address,
        longitude: restaurant["location"]["longitude"],
        latitude: restaurant["location"]["latitude"],
        opening_time: opening_time,
        closing_time: closing_time,
        google_rating: restaurant["rating"],
        cuisine: restaurant["cuisine"],
        pricing: price,
        description: restaurant["description"],
        website: website
      )
      price += 1

      images = restaurant['images']
      first_5_images = images.first(5)
      first_5_images.each_with_index do |image, idx|
        lib_uuid = image['libraryUuid']
        url_to_check_img_size = "https://tih-api.stb.gov.sg/media/v1/library/uuid/#{lib_uuid}?apikey=#{apikey}"
        library_parsed = JSON.parse(URI.open(url_to_check_img_size).read)
        if !library_parsed["data"]["thumbnail1080HUuid"].empty?
          uuid = library_parsed["data"]["thumbnail1080HUuid"]
        elsif !library_parsed["data"]["primaryFileMediumUuid"].empty?
          uuid = library_parsed["data"]["primaryFileMediumUuid"]
        elsif !library_parsed["data"]["primaryFileSmallUuid"].empty?
          uuid = library_parsed["data"]["primaryFileSmallUuid"]
        else
          uuid = library_parsed["data"]["primaryFile"]
        end
        url_to_download_restaurant_img = "https://tih-api.stb.gov.sg/media/v1/download/uuid/#{uuid}?apikey=#{apikey}"
        file = URI.open(url_to_download_restaurant_img)
        restaurant_instance.images.attach(io: file, filename: "#{restaurant['name']}_#{idx}.png", content_type: 'image/png')
      end
      restaurant_instance.save!
      puts "seeded #{restaurant['name']}"
      restaurant_counter += 1
      break if restaurant_counter == 4
    end
    break if next_token == "" || restaurant_counter == 4

    url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&nextToken=#{next_token}keyword=#{cuisine}&filtersource=stb&sortBy=rating&sortOrder=desc&language=en&apikey=#{apikey}"
  end
end

puts "Seeding restaurants completed"

puts "Destroying all Users to make humans extinct..."
User.destroy_all
puts "Creating New User called Adam"
User.create!(email: "test@test.com", username: "Adam", password: "password")
puts "Mankind is born (New User created)"

puts "Creating an Admin User called Eve"
User.create!(email: "admin@silverpierce.com", username: "Eve", password: "password", admin: true)
puts "Another human! (New Admin created)"
puts "Feel like a god!"

puts "Destroying Chomp sessions"
ChompSession.destroy_all
puts "Seeding Chomp sessions"
3.times do
  ChompSession.create(
    name: ['Somerset Dinner', 'EOY CosFest', 'Brunch@Yishun'].sample,
    date: Date.today + 2.days,
    time: Time.now + 2.hours,
    status: "closed",
    user: User.second,
    restaurant: Restaurant.all.sample
  )
end
2.times do
  ChompSession.create(
    name: ['Somerset Dinner', 'EOY CosFest', 'Brunch@Yishun'].sample,
    date: Date.today + 2.days,
    time: Time.now + 2.hours,
    status: "pending",
    user: User.second
  )
end
puts "Seeding ChompSessions completed, but will only work if you created a user account"

# chompSession for response_generation
ykbday = ChompSession.create!(
  name: "Yong kee's birthday",
  date: Time.now + 2.days,
  time: Time.now + 2.hours,
  status: "pending",
  user: User.second
)

puts "ykbday valid? #{ykbday.valid?}"

puts "Seeding fake response for testing"
response1 = Response.new(budget: 20, address: "19 Cuppage Rd, Singapore 229451", cuisine: ["", "Chinese", "Thai", "Japanese"])
response1.user = User.first
response1.chomp_session = ykbday
response1.save!

puts "Seeded response 1"
response2 = Response.new(budget: 5, address: "Upper Cross Street, Singapore, Central, 050034, Singapore", cuisine: [""])
response2.user = User.second
response2.chomp_session = ykbday
response2.save!
puts "Seeded response 2"
response3 = Response.new(budget: 25, address: "Woodlands, Singapore", cuisine: ["", "Asian", "Chinese", "Japanese", "Italian", "Halal", "Thai", "Desserts"])
response3.chomp_session = ykbday
response3.save!
puts "Seeded response 3"
puts "Seeded fake responses"
time_end = Time.now
time_taken = time_end - time_start
puts "Seeding completed! Took #{time_taken} seconds."
