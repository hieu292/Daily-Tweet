defmodule DailyTweetWeb.Integration.TweetMutationTest do
	use DailyTweetWeb.ConnCase
	alias DailyTweet.Worker.TopTweet
	alias DailyTweet.Model.Tweet
	alias DailyTweetWeb.Tweet.Resolver
	
	@create_mutation """
	mutation ($body: String!, $parentId: ID){
	 createTweet(body: $body, parentId: $parentId){
	   id
	   body
	   retweetCount
	 	parentId
	   updatedAt
	   insertedAt
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
	
	describe "Tweet Mutations" do
		test "create new tweet" do
			conn =
				build_conn()
				|> post(
					   "/api/graphql",
					   query: @create_mutation,
					   variables: %{
						   "body" => "test"
					   }
				   )
			
			tweet = json_response(conn, 200)["data"]["createTweet"]
			
			assert tweet["body"] == "test"
			assert is_nil(tweet["parentId"])
			refute is_nil(tweet["id"])
			assert is_binary(tweet["updatedAt"])
			assert is_binary(tweet["insertedAt"])
			assert tweet["retweetCount"] == 0
		end
		
		test "create new tweet with parent" do
			{:ok, parent_tweet} = Tweet.create(%{body: "parent"})
			
			conn =
				build_conn()
				|> post(
					   "/api/graphql",
					   query: @create_mutation,
					   variables: %{
						   "body" => "test",
						   "parentId" => to_string(parent_tweet.id)
					   }
				   )
			
			tweet = json_response(conn, 200)["data"]["createTweet"]
			
			assert tweet["body"] == "test"
			refute is_nil(tweet["id"])
			assert is_binary(tweet["updatedAt"])
			assert is_binary(tweet["insertedAt"])
			assert tweet["retweetCount"] == 0
			
			assert is_binary(tweet["parentId"])
			assert tweet["parent"]["body"] == "parent"
			assert tweet["parent"]["id"] == to_string(parent_tweet.id)
			assert is_binary(tweet["parent"]["updatedAt"])
			assert is_binary(tweet["parent"]["insertedAt"])
			assert tweet["parent"]["retweetCount"] == 1
		end
	end
	
end
