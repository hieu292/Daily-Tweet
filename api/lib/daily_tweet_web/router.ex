defmodule DailyTweetWeb.Router do
	use DailyTweetWeb, :router
	
	pipeline :api do
		plug :accepts, ["json"]
	end
	
	pipeline :browser do
		plug :accepts, ["html"]
		plug :fetch_session
		plug :fetch_flash
		plug :protect_from_forgery
		plug :put_secure_browser_headers
	end
	
	scope "/", DailyTweetWeb do
		pipe_through :browser
		
		get "/", PageController, :index
	end
	
	scope "/api" do
		pipe_through :api
		
		forward "/graphql", Absinthe.Plug, schema: DailyTweetWeb.Schema
		
		if Mix.env() == :dev do
			forward "/graphiql", Absinthe.Plug.GraphiQL,
					schema: DailyTweetWeb.Schema,
					socket: DailyTweetWeb.UserSocket,
					interface: :playground
		end
	end
end
