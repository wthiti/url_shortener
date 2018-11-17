defmodule UrlShortenerWeb.PageController do
  use UrlShortenerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def url(conn, %{"url" => url}) do
    url_shortener = url_shortener(url);
    json(conn, %{url: url_shortener})
  end

  def redirect_url(conn, %{"redirect_url" => redirect_url}) do
    redirect(conn, external: "http://elixir-lang.org")
  end

  defp url_shortener(url) do
    latestID = Integer.to_string(1)
    Base.encode64(latestID)
  end
end
