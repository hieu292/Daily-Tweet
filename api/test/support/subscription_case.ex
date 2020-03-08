defmodule DailyTweetWeb.SubscriptionCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use DailyTweetWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest, schema: DailyTweetWeb.Schema
	  import DailyTweet.Factory
	  
	  setup do
		  {:ok, socket} = Phoenix.ChannelTest.connect(DailyTweetWeb.UserSocket, %{})
		  {:ok, socket} = Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)
	
		  {:ok, socket: socket}
	  end
    end
  end
end
