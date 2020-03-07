defmodule DailyTweet.Worker.TopTweet do
	@moduledoc """
	This module defines top re-tweeted
	"""
	use GenServer
	
	alias DailyTweetWeb.SocketUtils
	
	@max_top 10
	
	def start_link(_) do
		GenServer.start_link(__MODULE__, [], name: __MODULE__)
	end
	
	def init(init_arg), do: {:ok, init_arg}
	
	def get(), do: GenServer.call(__MODULE__, :get)
	
	def get_current_min_retweet_count(), do: GenServer.call(__MODULE__, :get_min)
	
	def get_current_max_retweet_count(), do: GenServer.call(__MODULE__, :get_max)
	
	def reset(), do: GenServer.call(__MODULE__, :reset)
	
	def push(tweet), do: GenServer.call(__MODULE__, {:push, tweet})
	
	# Callbacks
	
	def handle_call(:get, _from, value),
		do: {:reply, value, value}
	
	def handle_call(:get_min, _from, value),
		do: {:reply, get_min_retweet_count(value), value}
	
	def handle_call(:get_max, _from, value),
		do: {:reply, get_max_retweet_count(value), value}
	
	def handle_call(:reset, _from, _value),
		do: {:reply, [], []}
	
	def handle_call({:push, tweet}, _from, old_state) do
		min_retweet_count = get_min_retweet_count(old_state)
		
		if tweet.retweet_count > min_retweet_count do
			value = get_new_top_tweets_state(old_state, tweet)

			SocketUtils.publish(value, [top_tweets: "top_tweets"]) # send to socket to update
			
			{:reply, :ok, value}
		else
			{:reply, :ok, old_state}
		end
	end
	
	defp get_new_top_tweets_state(old_state, new_tweet) do
		old_state
		|> Enum.reject(fn t -> t.id == new_tweet.id end)    # remove if exist tweet
		|> (&(&1 ++ [new_tweet])).()                        # append to list
		|> Enum.sort_by(&(&1.retweet_count))
		|> Enum.reverse
		|> Enum.take(@max_top)
	end
	
	defp get_min_retweet_count([]), do: 0
	
	defp get_min_retweet_count(sorted_tweets) do
		if length(sorted_tweets) < @max_top,
		   do: 0,
		   else: sorted_tweets
				 |> List.last
				 |> (&(&1.retweet_count)).()
	end
	
	defp get_max_retweet_count([]), do: 0
	
	defp get_max_retweet_count(sorted_tweets) do
		sorted_tweets
		|> List.first
		|> (&(&1.retweet_count)).()
	end
end
