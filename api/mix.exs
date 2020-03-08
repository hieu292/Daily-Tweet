defmodule DailyTweet.MixProject do
	use Mix.Project
	
	def project do
		[
			app: :daily_tweet,
			version: "0.1.0",
			elixir: "~> 1.5",
			elixirc_paths: elixirc_paths(Mix.env()),
			compilers: [:phoenix, :gettext] ++ Mix.compilers(),
			start_permanent: Mix.env() == :prod,
			deps: deps(),
			test_coverage: [
				tool: ExCoveralls
			],
			preferred_cli_env: [
				coveralls: :test,
				"coveralls.html": :test
			]
		]
	end
	
	# Configuration for the OTP application.
	#
	# Type `mix help compile.app` for more information.
	def application do
		[
			mod: {DailyTweet.Application, []},
			extra_applications: [:logger, :runtime_tools]
		]
	end
	
	# Specifies which paths to compile per environment.
	defp elixirc_paths(:test), do: ["lib", "test/support"]
	defp elixirc_paths(_), do: ["lib"]
	
	# Specifies your project dependencies.
	#
	# Type `mix help deps` for examples and options.
	defp deps do
		[
			{:phoenix, "~> 1.4.14"},
			{:phoenix_pubsub, "~> 1.1"},
			{:phoenix_ecto, "~> 4.0"},
			{:phoenix_html, "~> 2.11"},
			{:phoenix_live_reload, "~> 1.2", only: :dev},
			{:gettext, "~> 0.11"},
			{:jason, "~> 1.0"},
			{:plug_cowboy, "~> 2.0"},
			{:cors_plug, "~> 2.0"},
			{:excoveralls, "~> 0.10", only: :test},
			{:ecto, "~> 3.3.4"},
			{:etso, "~> 0.1.1"},
			{:absinthe, "~> 1.4.16"},
			{:absinthe_plug, "~> 1.4.6"},
			{:absinthe_phoenix, "~> 1.4.4"},
			{:faker, "~> 0.13", only: :test},
			{:ex_machina, "~> 2.3", only: :test},
		]
	end
end
