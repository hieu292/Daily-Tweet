defmodule DailyTweetWeb.Tweet.Resolver do
	alias DailyTweet.Model.Tweet
	alias DailyTweet.Worker.TopTweet
	
	def top_tweets(_, _, _) do
		{:ok, TopTweet.get()}
	end
	
	def all_tweets(_, _, _) do
		{:ok, Tweet.list_all()}
	end
	
	def create_tweet(_, args, _) do
		with {:ok, tweet} <- Tweet.create(args) do
			update_parent_retweet_count(tweet)
			{:ok, tweet}
		end
	end
	
	defp update_parent_retweet_count(%Tweet{parent_id: parent_id}) do
		with false <- is_nil(parent_id),
			 parent_tweet <- Tweet.find(parent_id),
			 false <- is_nil(parent_tweet),
			 retweet_count <- parent_tweet.retweet_count + 1,
			 {:ok, tweet} <- Tweet.update(parent_tweet, %{retweet_count: retweet_count})
			do
			TopTweet.push(tweet)
		end
	end
end
