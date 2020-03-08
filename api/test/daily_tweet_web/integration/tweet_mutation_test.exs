defmodule DailyTweetWeb.Integration.TweetMutationTest do
	use DailyTweetWeb.ConnCase

	@default_param %{
		"body" => Faker.Lorem.paragraph(1),
		"name" => Faker.Name.first_name(),
		"avatar" => Faker.Avatar.image_url()
	}

	@create_mutation """
	mutation ($body: String!, $name: String!, $avatar: String!, $parentId: ID){
	 createTweet(body: $body, name: $name, avatar: $avatar, parentId: $parentId){
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
			variables = %{ @default_param | "body" => "test"}

			conn =
				build_conn()
				|> post(
					   "/api/graphql",
					   query: @create_mutation,
					   variables: variables
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
			parent_tweet = insert(:tweet, body: "parent")
			
			variables = Map.merge(@default_param, %{
				"body" => "test",
				"parentId" => to_string(parent_tweet.id)
			})

			conn =
				build_conn()
				|> post(
					   "/api/graphql",
					   query: @create_mutation,
					   variables: variables
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
