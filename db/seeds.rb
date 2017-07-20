# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

puts "Creating User"
user = User.create(email: "email@example.com", password: "password")

puts "Creating Categories"
category_one = Category.create(name: "Category 1", user_id: user.id, amount: 20)
category_two = Category.create(name: "Category 2", user_id: user.id, amount: 60)
category_three = Category.create(name: "Category 2", user_id: user.id, amount: -33.33)

puts "Creating money records"
3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: category_one.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: category_two.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: category_three.id, adjusted_date: Date.today - rand(0...6).days)
end
