defmodule DailyTweet.TweetTest do
	use DailyTweetWeb.ConnCase, async: true
	
	alias DailyTweet.Model.Tweet
	
	@valid_attrs %{
		body: "Li Europan lingues es membres del sam familie.
			Lor separat existentie es un myth. Por scientie, musica,
			sport etc"
	}
	
	describe "Tweet.changeset/2" do
		@invalid_empty_body_attrs %{
			body: ""
		}
		@invalid_max_body_attrs %{
			body: "Li Europan lingues es membres del sam familie.
			Lor separat existentie es un myth. Por scientie, musica,
			sport etc, litot Europa usa li sam vo"
		}
		
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
