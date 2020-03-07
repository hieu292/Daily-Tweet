defmodule DailyTweet.TweetResolverTest do
	use DailyTweetWeb.ConnCase, async: true

	alias DailyTweet.Model.Tweet
	alias DailyTweet.Worker.TopTweet
	alias DailyTweetWeb.Tweet.Resolver
	alias DailyTweet.Repo

	@valid_attrs %{
		body: "Li Europan lingues es membres del sam familie.
			Lor separat existentie es un myth. Por scientie, musica,
			sport etc"
	}

	describe "Resolver.create_tweet/3" do
		test "Tweet created and all attributes are saved properly" do
			{:ok, tweet} = Resolver.create_tweet(nil, @valid_attrs, nil)
			tweet = Repo.get!(Tweet, tweet.id)

			assert tweet.body == @valid_attrs[:body]
			assert tweet.retweet_count == 0
			refute is_nil(tweet.id)
		end

		test "Tweet created with parent tweet and all attributes are saved properly" do
			{:ok, parent_tweet} = Resolver.create_tweet(nil, @valid_attrs, nil)
			{:ok, tweet} =
				@valid_attrs
				|> Map.merge(%{parent_id: parent_tweet.id})
				|> (&Resolver.create_tweet(nil, &1, nil)).()

			parent_tweet = Repo.get!(Tweet, parent_tweet.id)
			top_tweet = TopTweet.get()

			refute is_nil(tweet.parent_id)
			assert parent_tweet.retweet_count == 1
			assert length(top_tweet) == 1
		end
	end
end
