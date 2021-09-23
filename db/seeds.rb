require 'open-uri'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing restaurants db"

puts "clearing db"

# should i destroy other datas like users, etc
Restaurant.destroy_all
puts "Seeding db with restaurants"
apikey = "ytxKCmRhV2kPY8fEpKXN63SuuQSkVmPw"
# api to download images based on uuid
url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&language=en&apikey=#{apikey}"
count = 0
client = Pexels::Client.new
loop do
  count += 1
  fnb_serialized = URI.open(url).read
  fnb_parsed = JSON.parse(fnb_serialized)
  next_token = fnb_parsed["nextToken"]
  puts "next token is: #{next_token}"
  length_of_results = fnb_parsed["data"]["results"].length
  length_of_results.times do |index|
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
      # rating: restaurant["rating"],
      cuisine: restaurant["cuisine"]
    )
    uuid = restaurant['thumbnails'].first['uuid'] if !restaurant['thumbnails'].empty? && !restaurant['thumbnails'].first['uuid'].empty?
    if uuid.nil?
      # photos = client.photos.search('restaurant', size: :small, orientation: :landscape)
      file = URI.open("https://images.pexels.com/photos/1484516/pexels-photo-1484516.jpeg?auto=compress&cs=tinysrgb&h=130")
    else
      url_to_download_restaurant_img = "https://tih-api.stb.gov.sg/media/v1/download/uuid/#{uuid}?apikey=#{apikey}"
      file = URI.open(url_to_download_restaurant_img)
    end
    restaurant_instance.image.attach(io: file, filename: 'restaurant["name"].png', content_type: 'image/png')
    restaurant_instance.save
    puts "seeded #{restaurant["name"]}"
  end
  # break if next_token==""
  break if count == 1
  url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&nextToken=#{next_token}&language=en&apikey=#{apikey}"
end
puts "Seeding restaurants completed"

puts "Creating New User"
User.create!(email: "test@test.com", username: "tester", password: "password")
puts "New User created"

puts "Destroying Chomp sessions"
ChompSession.destroy_all
puts "Seeding Chomp sessions"
3.times do
  ChompSession.create(
    name: ['Somerset Dinner', 'EOY CosFest', 'Brunch@Yishun'].sample,
    date: Date.today,
    time: Time.now,
    status: ["pending", "closed"].sample,
    restaurant: Restaurant.last,
    user: User.last
  )
end
puts "Seeding ChompSessions completed, but will only work if you created a user account"

puts "Creating fake response for testing"
response = Response.new(budget: 5, location: "34 Upper Cross Street, Singapore", email: "test@test.com", cuisine: "[Chinese]" )
response.user = User.first
cs = ChompSession.first
response.chomp_session = cs
response.save!
puts "Seeding fake response"

puts "Seeding completed!"
