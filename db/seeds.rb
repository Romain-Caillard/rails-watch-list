# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# --> Je copie colle le code de Thibault pour "appeler(call)" l'API donnée dans l'exo
puts "Cleaning database..."
sleep(2)
List.destroy_all
Movie.destroy_all

require 'open-uri'
require 'json'
url = "https://tmdb.lewagon.com/movie/top_rated"
serialized_file = URI.open(url).read
file = JSON.parse(serialized_file)
file["results"].each do |result|
  Movie.create(
    title: result["title"],
    overview: result["overview"],
    rating: result["vote_average"],
    poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}"
  )
  puts "created #{result["title"]}"
  sleep(1)
end
list_one = List.create(name: "The best movie")
list_two = List.create(name: "All good movies")
Bookmark.create(movie: Movie.all.first, list: list_one, comment: "testtest")
Bookmark.create(movie: Movie.all.last, list: list_one, comment: "testtest")
Bookmark.create(movie: Movie.all.last, list: list_two, comment: "testtest")

