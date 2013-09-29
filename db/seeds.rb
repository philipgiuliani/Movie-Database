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