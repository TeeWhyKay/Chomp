puts "Clearing restaurant database..."
Restaurant.destroy_all
puts 'Creating restaurants...'
Restaurant.create!({
  name: "Le Dindon en Laisse",
  address: "18 Rue Beautreillis, 75004 Paris, France",
  photo_url: "https://source.unsplash.com/featured/?food"
})
Restaurant.create!({
  name: "Neuf et Voisins",
  address: "Van Arteveldestraat 1, 1000 Brussels, Belgium",
  photo_url: "https://source.unsplash.com/featured/?food"
})
puts 'Finished!'

# This is just a sample so I can test the review features
