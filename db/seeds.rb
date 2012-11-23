# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

AdminUser.create! email: "admin@example.org", password: "foobarspam"
puts "Created administrator `admin@example.org` with password `foobarspam`."
puts "Change these by visiting http://localhost/admin"

