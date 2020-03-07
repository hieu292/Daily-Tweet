defmodule DailyTweet.Presence do
	use Phoenix.Presence,
		otp_app: :daily_tweet,
		pubsub_server: DailyTweet.PubSub
end
