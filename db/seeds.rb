require 'random_data'
require 'faker'

5.times do

	pw = RandomData.random_sentence

	user = User.create!(
		# email: RandomData.random_email,
		email: Faker::Internet.unique.free_email,
		password: pw,
		password_confirmation: pw,
		confirmed_at: Date.today,
	)

	user.update_attribute(:confirmed_at, rand(10.minutes .. 1.year).ago)
end

users = User.all

15.times do
	Wiki.create!(
	title: Faker::GameOfThrones.unique.character,
	body: RandomData.random_paragraph,
	user: users.sample
	)

end

User.create!(
	email: "admin@gmail.com",
	password: "password",
	password_confirmation: "password",
	confirmed_at: Date.today,
	role: 'admin'
)

User.create!(
	email: "premium@gmail.com",
	password: "password",
	password_confirmation: "password",
	confirmed_at: Date.today,
	role: 'premium'
)

User.create!(
	email: "standard@gmail.com",
	password: "password",
	password_confirmation: "password",
	confirmed_at: Date.today,
	role: 'standard'
)

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
