defmodule DailyTweetWeb.TweetSubscriptionTest do
	use DailyTweetWeb.SubscriptionCase
	alias DailyTweet.Worker.TopTweet
	alias DailyTweet.Model.Tweet

	@default_param %{
		"body" => Faker.Lorem.paragraph(1),
		"name" => Faker.Name.first_name(),
		"avatar" => Faker.Avatar.image_url()
	}

	@subscription_create_tweet """
	  subscription {
	    tweetCreated {
			id
			body
			retweetCount
			parentId
			updatedAt
			insertedAt
	    }
	  }
	"""

	@subscription_update_top_tweets """
	  subscription {
	    topTweets {
			id
			body
			retweetCount
			parentId
			updatedAt
			insertedAt
	    }
	  }
	"""

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

	setup do
		TopTweet.reset()

		# Reset all data
		Tweet.list_all()
		|> Enum.each(&Tweet.delete/1)
	end

	describe "Tweet subscription" do
		test "create new tweet", %{socket: socket} do
			ref = push_doc(socket, @subscription_create_tweet)

			assert_reply(ref, :ok, %{subscriptionId: _subscription_id})

			ref = push_doc(socket, @create_mutation, variables: %{@default_param | "body" => "test"})

			assert_reply(ref, :ok, reply)
			data = reply.data["createTweet"]
			assert data["body"] == "test"

			assert_push("subscription:data", push)
			data = push.result.data["tweetCreated"]
			assert data["body"] == "test"
		end

		test "update top tweets", %{socket: socket} do
			ref = push_doc(socket, @subscription_update_top_tweets)

			assert_reply(ref, :ok, %{subscriptionId: _subscription_id})
			
			parent_tweet = insert(:tweet, body: "parent")
			
			variables = Map.merge(@default_param, %{
				"body" => "test",
				"parentId" => to_string(parent_tweet.id)
			})
			
			ref = push_doc(
				socket,
				@create_mutation,
				variables: variables
			)

			assert_reply(ref, :ok, reply)

			assert_push("subscription:data", push)
			data = push.result.data["topTweets"]

			assert length(data) == 1
			assert List.first(data)["id"] == to_string(parent_tweet.id)
		end
	end
end
