defmodule DailyTweetWeb.SocketUtils do
	def publish(results, subscriptions) do
		Absinthe.Subscription.publish(DailyTweetWeb.Endpoint, results, subscriptions)
	end
end
