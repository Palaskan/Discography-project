# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Limpiar la base de datos antes de crear nuevos datos (opcional)
Artist.destroy_all
Author.destroy_all
Lp.destroy_all
Song.destroy_all

# Creando los artistas
metallica = Artist.create!(name: "Metallica", description: "Metallica band description")
sepultura = Artist.create!(name: "Sepultura", description: "Sepultura band description")

# Creando los autores
hetfield = Author.create!(name: "Hetfield", description: "Hetfield author description")
jason_n = Author.create!(name: "Jason N", description: "Jason N author description")
hammett = Author.create!(name: "Hammett", description: "Hammett author description")

# Creando los LPs
black_album = metallica.lps.create!(name: "Black Album", description: "Album Metallica description")
against = sepultura.lps.create!(name: "Against", description: "Album Sepultura description")

# Creando las canciones y asociando artistas y autores
my_friend_of_misery = black_album.songs.create!(name: "My Friend of Misery", description: "By Hetfield and Jason N.")
my_friend_of_misery.authors << [hetfield, jason_n]

enter_sandman = black_album.songs.create!(name: "Enter Sandman", description: "By Hetfield")
enter_sandman.authors << hetfield

unforgiven = black_album.songs.create!(name: "Unforgiven", description: "By Hetfield and Hammett")
unforgiven.authors << [hetfield, hammett]

hatred_aside = against.songs.create!(name: "Hatred Aside", description: "By Jason N.")
hatred_aside.authors << jason_n
