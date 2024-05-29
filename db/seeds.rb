# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create(email: 'humblebragger@humblebrag.com', password: 'humblebaby', username: 'humblebragger')
User.create(email: 'fitnessgrampacer@test.com', password: 'pacertest', username: 'fitnessgrampacer')
User.create(email: "charlie@gmail.com", password: "password123", username: "usercharlie")
User.create(email: "jeff@gmail.com", password: "password234", username: "userjeff")
User.create(email: "ali@gmail.com", password: "123password", username: "userali")
User.create(email: "josh@gmail.com", password: "234password", username: "userjosh")