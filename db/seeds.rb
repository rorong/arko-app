# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do |n|
  user = User.create(
    email: "deepti.sharma+#{n}@ongraph.com",
    password: 'password',
    phone_number: '+919999999999'
  )

  if user
    user.create_address_detail(
      street: "street #{n}", landmark: 'Noida', state: 'UP', country: 'India'
    )
  end
end
