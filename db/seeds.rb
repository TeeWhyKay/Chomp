require 'open-uri'

puts "Clearing restaurants db"
Restaurant.destroy_all
puts "Seeding db with restaurants"
apikey = "ytxKCmRhV2kPY8fEpKXN63SuuQSkVmPw"
# api to download images based on uuid
# url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&language=en&apikey=#{apikey}"
cuisine_arr = %w[Asian Chinese Western Japanese Italian Halal Indian Thai Korean Local Steamboat Desserts]
client = Pexels::Client.new
cuisine_arr.each do |cuisine|
  puts "--- searching #{cuisine} --- "
  url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&keyword=#{cuisine}&sortBy=rating&sortOrder=desc&language=en&apikey=#{apikey}"
  count = 0
  loop do
    count += 1
    fnb_serialized = URI.open(url).read
    fnb_parsed = JSON.parse(fnb_serialized)
    next_token = fnb_parsed["nextToken"]
    # puts "next token is: #{next_token}"
    random_index_arr = (0..19).to_a.shuffle!
    # length_of_results = fnb_parsed["data"]["results"].length
    # length_of_results.times do |index|
    price =  1
    4.times do
      index = random_index_arr.pop
      restaurant = fnb_parsed["data"]["results"][index]
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
        body: restaurant["body"].delete('\n')
      )
      price += 1
      # uuid = restaurant['thumbnails'].first['uuid'] if !restaurant['thumbnails'].empty? && !restaurant['thumbnails'].first['uuid'].empty?
      # if uuid.nil?
      #   # photos = client.photos.search('restaurant', size: :small, orientation: :landscape)
      #   file = URI.open("https://images.pexels.com/photos/1484516/pexels-photo-1484516.jpeg?auto=compress&cs=tinysrgb&h=130")
      # else
      #   url_to_download_restaurant_img = "https://tih-api.stb.gov.sg/media/v1/download/uuid/#{uuid}?apikey=#{apikey}"
      #   file = URI.open(url_to_download_restaurant_img)
      # end
      # restaurant_instance.image.attach(io: file, filename: 'restaurant["name"].png', content_type: 'image/png')
      restaurant_instance.save
      puts "seeded #{restaurant["name"]}"
    end
    # break if next_token==""
    break if count == 1
    # url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&nextToken=#{next_token}&language=en&apikey=#{apikey}"
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
5.times do
  ChompSession.create(
    name: ['Somerset Dinner', 'EOY CosFest', 'Brunch@Yishun'].sample,
    date: Date.today,
    time: Time.now,
    status: ["pending", "closed"].sample,
    user: User.second
  )
end
puts "Seeding ChompSessions completed, but will only work if you created a user account"

# chompSession for response_generation
ykbday = ChompSession.create(
    name: "Yong kee's birthday",
    date: Date.today,
    time: Time.now,
    status: "pending",
    user: User.second
)

puts "Seeding fake response for testing"
response1 = Response.new(budget: 20, address: "19 Cuppage Rd, Singapore 229451", cuisine: ["", "Chinese", "Thai", "Japanese"])
response1.user = User.first
response1.chomp_session = ykbday
response1.save!

response2 = Response.new(budget: 5, address: "Upper Cross Street, Singapore, Central, 050034, Singapore", cuisine: [""])
response2.user = User.second
response2.chomp_session = ykbday
response2.save!

response3 = Response.new(budget: 25, address: "Woodlands, Singapore", cuisine: ["", "Asian", "Chinese", "Japanese", "Italian", "Halal", "Thai", "Desserts"])
response3.chomp_session = ykbday
response3.save!

puts "Seeded fake responses"

puts "Seeding completed!"
