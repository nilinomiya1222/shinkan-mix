# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach('db/seeds/lg_genres.csv') do |row|
  LgGenre.create(id: row[0], name: row[1])
end
CSV.foreach('db/seeds/genres.csv') do |row|
  Genre.create(id: row[0], lg_genre_id: row[1], name: row[2], type: row[3])
end
CSV.foreach('db/seeds/points.csv') do |row|
  Genre.create(id: row[0], name: row[1], type: row[2])
end