defmodule DailyTweetWeb.PageController do
  use DailyTweetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
