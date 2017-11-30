FactoryGirl.define do

	factory :user do

		sequence(:email){|n| "user#{n}@factory.com" }

		password 				"password"
		password_confirmation 	"password"
		confirmed_at Date.today

	end

end
