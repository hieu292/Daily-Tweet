defmodule DailyTweet.Factory do
	use ExMachina.Ecto, repo: DailyTweet.Repo
	alias DailyTweet.Model.Tweet
	
	def tweet_factory do
		%Tweet{
			body: Faker.Lorem.paragraph(1),
			name: Faker.Name.first_name(),
			avatar: Faker.Avatar.image_url()
		}
	end
end
