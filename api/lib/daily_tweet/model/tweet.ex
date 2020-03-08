defmodule DailyTweet.Model.Tweet do
	use DailyTweet.Model
	
	@url_regex ~r/^https?:\/\/[^\s$.?#].[^\s]*$/
	
	schema "tweets" do
		field :body, :string
		field :name, :string
		field :avatar, :string
		field :retweet_count, :integer, default: 0
		belongs_to :parent, __MODULE__
		
		timestamps()
	end
	
	def changeset(tweet, attrs) do
		tweet
		|> cast(attrs, [:body, :name, :avatar, :parent_id, :retweet_count])
		|> validate_required([:body, :name, :avatar])
		|> validate_length(:body, min: 1, max: 140)
		|> validate_format(:avatar, @url_regex)
		|> foreign_key_constraint(:parent_id)
	end
end
