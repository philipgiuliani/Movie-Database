# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Quality.create([
	{name: "Schlecht (360p)", resolution_x: 640, resolution_y: 360},
	{name: "Normal (480p)", resolution_x: 854, resolution_y: 480},
	{name: "HD (720p)", resolution_x: 1280, resolution_y: 720},
	{name: "Full-HD (1080p)", resolution_x: 1920, resolution_y: 1080},
	{name: "Ultra-HD (2160p)", resolution_x: 3840, resolution_y: 2160}
]);

Genre.create([
	{id: 1, name: "Abenteuer"},
	{id: 2,name: "Action"},
	{id: 3,name: "Animation"},
	{id: 4,name: "Dokumentarfilm"},
	{id: 5,name: "Drama"},
	{id: 6,name: "Familie"},
	{id: 7,name: "Eastern"},
	{id: 8,name: "Fantasy"},
	{id: 9,name: "Geschichte"},
	{id: 10,name: "Horror"},
	{id: 11,name: "Komödie"},
	{id: 12,name: "Krimi"},
	{id: 13,name: "Thriller"},
	{id: 14,name: "Science Fiction"},
	{id: 15,name: "Lovestory"},
	{id: 16,name: "Mystery"},
	{id: 17,name: "Familie"}, # is two times in the genres list
	{id: 18,name: "Sport"},
	{id: 19,name: "Western"},
	{id: 20,name: "Holiday"}
]);

Genre.find(17).destroy