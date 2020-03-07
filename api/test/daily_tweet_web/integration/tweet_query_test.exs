defmodule DailyTweetWeb.Integration.TweetQueryTest do
	use DailyTweetWeb.ConnCase
	alias DailyTweet.Worker.TopTweet
	alias DailyTweet.Model.Tweet
	alias DailyTweetWeb.Tweet.Resolver
	
	describe "Tweet Queries" do
		setup do
			TopTweet.reset()
			
			# Reset all data
			Tweet.list_all()
			|> Enum.each(&Tweet.delete/1)
		end
		
		@top_query """
		query {
		  topTweets{
		    id
		    body
		    retweetCount
		    updatedAt
		    insertedAt
		  	parentId
		    parent {
		      id
		      body
		      retweetCount
		      updatedAt
		    	insertedAt
		    }
		  }
		}
		"""
		test "return top 10 tweets" do
			{:ok, parent_tweet} = Tweet.create(%{body: "test1"})
			Resolver.create_tweet(nil, %{body: "test2", parent_id: parent_tweet.id}, nil)
			
			conn =
				build_conn()
				|> post("/api/graphql", query: @top_query)
			
			top_tweets = json_response(conn, 200)["data"]["topTweets"]
			assert List.first(top_tweets)["id"] == to_string(parent_tweet.id)
		end
		
		@list_query """
			query {
				  tweets{
				    id
				    body
				    retweetCount
				    updatedAt
				    insertedAt
				  	parentId
				    parent {
				      id
				      body
				      retweetCount
				      updatedAt
				    	insertedAt
				    }
				  }
				}
		"""
		test "return list all tweets" do
			Tweet.create(%{body: "test1"})
			Tweet.create(%{body: "test2"})
			
			conn =
				build_conn()
				|> post("/api/graphql", query: @list_query)
			
			tweets = json_response(conn, 200)["data"]["tweets"]
			assert length(tweets) == 2
		end
	end
end
