# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(email: "admin@course.com")
  User.create!(email: "admin@course.com", password: "password", admin: true
  )
end

unless User.exists?(email: "viewer@course.com")
  User.create!(email: "viewer@course.com", password: "password")
end

["C++ framework", "Linux kernel"].each do |name|
  unless Course.exists?(name: name)
    Course.create!(name: name, description: "A sample course about #{name}"
    )
  end
end
