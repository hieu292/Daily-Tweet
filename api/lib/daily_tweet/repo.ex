defmodule DailyTweet.Repo do
	use Ecto.Repo,
		otp_app: :daily_tweet,
		adapter: Etso.Adapter
end
