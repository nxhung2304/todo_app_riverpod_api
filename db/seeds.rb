# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create! email: "user@example.com", password: "123456", full_name: "User"
puts "Created a User: #{user.email}"

todo = user.todos.create! title: "Todo 1"
puts "Created a Todo: #{todo.title}"

category = user.categories.create! name: "Home"
puts "Created a Category: #{todo.title}"
