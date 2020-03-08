defmodule DailyTweet.TweetTest do
	use DailyTweetWeb.ConnCase, async: true
	
	alias DailyTweet.Model.Tweet
	
	@valid_attrs %{
		body: Faker.Lorem.paragraph(1),
		name: Faker.Name.first_name(),
		avatar: Faker.Avatar.image_url()
	}
	
	describe "Tweet.changeset/2" do
		@invalid_empty_body_attrs 	%{@valid_attrs | body: ""}
		
		@invalid_max_body_attrs 	%{@valid_attrs | body: Faker.Lorem.paragraph(10)}
		
		test "changeset with valid attributes" do
			changeset = Tweet.changeset(%Tweet{}, @valid_attrs)

			assert changeset.valid?
		end
		
		test "changeset with invalid attributes: empty in body" do
			changeset = Tweet.changeset(%Tweet{}, @invalid_empty_body_attrs)
			
			refute changeset.valid?
		end
		
		test "changeset with invalid attributes: max 140 characters in body" do
			changeset = Tweet.changeset(%Tweet{}, @invalid_max_body_attrs)
			
			refute changeset.valid?
		end
	end
end
