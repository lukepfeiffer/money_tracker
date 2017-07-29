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
category_three = Category.create(name: "Category 3", user_id: user.id, amount: -33.33)
archived_one = Category.create(name: "Category 3", user_id: user.id, amount: -50, archived_at: DateTime.now)
archived_two = Category.create(name: "Category 3", user_id: user.id, amount: 70, archived_at: DateTime.now - 1.day)
archived_three = Category.create(name: "Category 3", user_id: user.id, amount: 1020, archived_at: DateTime.now - 2.days)

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

puts "Creating archived records"

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: archived_one.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: archived_two.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: archived_three.id, adjusted_date: Date.today - rand(0...6).days)
end


puts "Creating PaycheckUser"
user2= User.create(email: "paycheck@example.com", password: "password", use_paycheck: true)

puts "Creating Paycheck Categories"
paycheck_category_one = Category.create(name: "Paycheck Category 1", user_id: user2.id, paycheck_percentage: 25, amount: 0)
paycheck_category_two = Category.create(name: "Paycheck Category 2", user_id: user2.id, paycheck_percentage: 30, amount: 0)
paycheck_category_three = Category.create(name: "Paycheck Category 3", user_id: user2.id, paycheck_percentage: 35, amount: 0)
p_archived_one = Category.create(name: "Paycheck Category 1", user_id: user2.id, paycheck_percentage: 25, amount: 0, archived_at: DateTime.now)
p_archived_two = Category.create(name: "Paycheck Category 2", user_id: user2.id, paycheck_percentage: 30, amount: 0, archived_at: DateTime.now - 1.day)
p_archived_three = Category.create(name: "Paycheck Category 3", user_id: user2.id, paycheck_percentage: 35, amount: 0, archived_at: DateTime.now - 2.days)

puts "Create paychecks"
Paycheck.create(date_received: Date.today, amount: 500, user_id: user2.id, amount_left: 500)
puts "Creating paycheck money records"
3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: paycheck_category_one.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: paycheck_category_two.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: paycheck_category_three.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: p_archived_one.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: p_archived_two.id, adjusted_date: Date.today - rand(0...6).days)
end

3.times do
  MoneyRecord.create(description: Faker::Lorem.sentence, amount: rand(-111.0...100.0).round(2), category_id: p_archived_three.id, adjusted_date: Date.today - rand(0...6).days)
end
