# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "clearing db"
# should i destroy other datas like users, etc
Restaurant.destroy_all
puts "seeding db with restaurants"
apikey = "ytxKCmRhV2kPY8fEpKXN63SuuQSkVmPw"
url_to_download_restaurant_img = "https://tih-api.stb.gov.sg/media/v1/download/uuid/10191b8e2d015b5498b8d7793385b400ae1&apikey=#{apikey}"
url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&language=en&apikey=#{apikey}"
count = 0
loop do
  count += 1
  address_serialized = URI.open(url).read
  address_parsed = JSON.parse(address_serialized)
  next_token = address_parsed["nextToken"]
  puts "next token is: #{next_token}"
  length_of_results = address_parsed["data"]["results"].length
  length_of_results.times do |index|
    address = address_parsed["data"]["results"][index]["address"]
    full_address = "
    #{address['block']}
    #{address['streetName']}
    #{address['floorNumber']}-#{address['unitNumber']}
    #{address['buildingName']} #{address['postalCode']}, Singapore"
    time = address_parsed["data"]["results"][index]["businessHour"]
    if time.empty?
      opening_time = ["10:00", "10:30", "11:00"].sample
      closing_time = ["22:00", "22:30", "23:00"].sample
    else
      opening_time = time.first["openTime"]
      closing_time = time.first["closeTime"]
    end
    restaurant = Restaurant.create(
      name: address_parsed["data"]["results"][index]["name"],
      address: full_address,
      longitude: address_parsed["data"]["results"][index]["location"]["longitude"],
      latitude: address_parsed["data"]["results"][index]["location"]["latitude"],
      opening_time: opening_time,
      closing_time: closing_time,
      # rating: address_parsed["data"]["results"][index]["rating"],
      cuisine: address_parsed["data"]["results"][index]["cuisine"]
    )
    puts "seeded #{address_parsed["data"]["results"][index]["name"]}"
  end
  # break if next_token==""
  break if count == 1
  url = "https://tih-api.stb.gov.sg/content/v1/search/all?dataset=food_beverages&nextToken=#{next_token}&language=en&apikey=#{apikey}"
end
puts "seeding restaurant completed"
