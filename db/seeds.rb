require 'random_data'

# Create Users
5.times do

	pw = RandomData.random_sentence

	user = User.create!(
		email: RandomData.random_email,
		password: pw,
		password_confirmation: pw,
		confirmed_at: Date.today,
	)

	user.update_attribute(:confirmed_at, rand(10.minutes .. 1.year).ago)
end

users = User.all

# Create Wikis
15.times do
		Wiki.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
		user: users.sample
	)

end

# Create 2 custom users to be used during development
User.create!(
	email: "aamarill.engr@gmail.com",
	password: "password",
	password_confirmation: "password",
	confirmed_at: Date.today
)

User.create!(
	email: "aamarill.engr2@gmail.com",
	password: "password",
	password_confirmation: "password",
	confirmed_at: Date.today
)



puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"




# Example from Bloccit
# By Adan Amarillas

# require 'random_data'
#
# # Create Users
# 5.times do
# 	User.create!(
# 	name: RandomData.random_name,
# 	email: RandomData.random_email,
# 	password: RandomData.random_sentence
# 	)
# end
# users = User.all
#
# # Create topics
# 15.times do
# 	Topic.create!(
# 		name: RandomData.random_sentence,
# 		description: RandomData.random_paragraph
# 	)
# end
#
# topics = Topic.all
#
# # Create posts
# 50.times do
# 	post = Post.create!(
# 		user: users.sample,
# 		topic: topics.sample,
# 		title: RandomData.random_sentence,
# 		body:  RandomData.random_paragraph
# 	)
# 	post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
# 	rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
#
# end
#
#
#
#
# posts = Post.all
#
# # Create comments
# 100.times do
# 	Comment.create!(
# 		user: users.sample,
# 		post: posts.sample,
# 		body: RandomData.random_paragraph
# 	)
# end
#
# # Create an admin user
#  admin = User.create!(
#    name:     'Admin User',
#    email:    'admin@example.com',
#    password: 'helloworld',
#    role:     'admin'
#  )
#
#  # Create a member
#  member = User.create!(
#    name:     'Member User',
#    email:    'member@example.com',
#    password: 'helloworld'
#  )
#
# puts "Seed Finished"
# puts "#{User.count} users created"
# puts "#{Topic.count} topics created"
# puts "#{Post.count} posts created"
# puts "#{Comment.count} comments created"
# puts "#{Vote.count} votes created"
