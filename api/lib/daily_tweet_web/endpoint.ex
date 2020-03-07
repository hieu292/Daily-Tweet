defmodule DailyTweetWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :daily_tweet
  use Absinthe.Phoenix.Endpoint
  
  origin =
	  cond do
		  Mix.env == :prod ->
			  ["//*.firebase.com"]
		  true -> ["*"]
	  end
  
  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_daily_tweet_key",
    signing_salt: "xC8LKMWJ"
  ]

  socket "/socket", DailyTweetWeb.UserSocket,
    websocket: [
		check_origin: (if Mix.env == :prod, do: origin, else: false)
	],
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :daily_tweet,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug CORSPlug, origin: origin
  plug DailyTweetWeb.Router
end
