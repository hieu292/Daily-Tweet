defmodule DailyTweetWeb.Schema do
	use Absinthe.Schema
	import_types Absinthe.Plug.Types
	import_types Absinthe.Type.Custom
	import_types DailyTweetWeb.Tweet.Types
	
	query do
		import_fields(:tweet_queries)
	end
	
	mutation do
		import_fields(:tweet_mutations)
	end
	
	subscription do
		import_fields(:tweet_subscriptions)
	end
	
end
