defmodule DailyTweetWeb.Tweet.Types do
	use Absinthe.Schema.Notation
	
	alias DailyTweetWeb.Tweet.Resolver
	alias DailyTweet.Model.Tweet
	
	@desc "A parent tweet"
	object :parent_tweet do
		field :id, :id
		field :body, :string
		field :retweet_count, :integer
		field :updated_at, :string
		field :inserted_at, :string
	end
	
	@desc "A tweet"
	object :tweet do
		field :id, :id
		field :body, :string
		field :retweet_count, :integer
		field :parent_id, :id
		field :updated_at, :string
		field :inserted_at, :string
		field :parent, :parent_tweet do
			resolve(
				fn tweet, _, _ ->
					case tweet.parent_id do
						nil -> {:ok, nil}
						parent_id -> {:ok, Tweet.find(parent_id)}
					end
				end
			)
		end
	end
	
	object :tweet_queries do
		@desc "Get top 10 tweets"
		field :top_tweets, list_of(:tweet) do
			resolve(&Resolver.top_tweets/3)
		end
		
		@desc "Get all tweets"
		field :tweets, list_of(:tweet) do
			resolve(&Resolver.all_tweets/3)
		end
	end
	
	object :tweet_mutations do
		@desc "Create tweet"
		field :create_tweet, :tweet do
			arg(:parent_id, :id)
			arg(:body, non_null(:string))
			
			resolve(&Resolver.create_tweet/3)
		end
	end
	
	object :tweet_subscriptions do
		field :tweet_created, :tweet do
			config(fn _, _ ->
					{:ok, topic: "tweet"}
			end)
			
			trigger(:create_tweet,
				topic: fn _ ->
					"tweet"
				end
			)
		end
		
		field :top_tweets, list_of(:tweet) do
			config(fn _, _ ->
				{:ok, topic: "top_tweets"}
			end)
		end
	end
end
