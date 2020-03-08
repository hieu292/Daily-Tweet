defmodule DailyTweet.TopTweetTest do
	use DailyTweetWeb.ConnCase
	
	alias DailyTweet.Worker.TopTweet
	
	setup do
		TopTweet.reset()
	end
	
	test "push new tweet" do
		generate_and_push_tweet(0)
		assert TopTweet.get() == []
	end
	
	test "top tweet state with length < 10" do
		3..1
		|> Enum.map(&generate_and_push_tweet/1)
		
		assert TopTweet.get_current_min_retweet_count == 0
		assert TopTweet.get_current_max_retweet_count() == 3
		assert length(TopTweet.get()) == 3
	end
	
	test "top tweet state with length >= 10" do
		11..1
		|> Enum.map(&generate_and_push_tweet/1)
		
		assert TopTweet.get_current_min_retweet_count() == 2
		assert TopTweet.get_current_max_retweet_count() == 11
		assert length(TopTweet.get()) == 10
	end
	
	defp generate_and_push_tweet(id) do
		id
		|> generate_tweet
		|> TopTweet.push()
	end
	
	defp generate_tweet(id),
		 do: insert(:tweet, retweet_count: id)
end
