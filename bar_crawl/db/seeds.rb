# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'

filename = File.expand_path('../Bars.csv', __FILE__)

CSV.foreach(filename, :headers=>true) do |csv_obj|
  Bar.create({
    name: csv_obj['DOING BUSINESS AS NAME'],
    address: csv_obj['ADDRESS'],
    city: csv_obj['CITY'],
    state: csv_obj['STATE'],
    zip: csv_obj['ZIP CODE'],
    license: csv_obj['LICENSE DESCRIPTION'],
    lat: csv_obj['LATITUDE'].to_f,
    long: csv_obj['LONGITUDE'].to_f,
    loc: csv_obj['LOCATION']
    })
end
