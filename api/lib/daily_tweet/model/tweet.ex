defmodule DailyTweet.Model.Tweet do
	use DailyTweet.Model
	
	schema "tweets" do
		field :body, :string
		field :retweet_count, :integer, default: 0
		belongs_to :parent, __MODULE__
		
		timestamps()
	end
	
	def changeset(tweet, attrs) do
		tweet
		|> cast(attrs, [:body, :parent_id, :retweet_count])
		|> validate_required([:body])
		|> validate_length(:body, min: 1, max: 140)
		|> foreign_key_constraint(:parent_id)
	end
end
