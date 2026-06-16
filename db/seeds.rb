# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "================================="
puts "Seeding administrators..."
puts "================================="

admin = Administrator.find_or_create_by(email: "admin@kit.com") do |a|
  a.password = "ChangeMe123!"
  a.password_confirmation = "ChangeMe123!"
  a.role = "super_admin"
end

puts "Admin exists: #{admin.email}"
puts "Total admins: #{Administrator.count}"