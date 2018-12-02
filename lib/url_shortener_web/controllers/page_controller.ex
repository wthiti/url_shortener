defmodule UrlShortenerWeb.PageController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.Repo
  alias UrlShortener.Url

  import Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def url(conn, %{"url" => url}) do
    replaced_url = replace_url(url)
    url_shortener = url_shortener(replaced_url)

    change_params = %{origin: replaced_url, shorten: url_shortener}
    changeset = Url.List.changeset(%Url.List{}, change_params)

    case Repo.insert(changeset) do
      {:ok, _list} ->
        json(conn, %{url: url_shortener})
      {:error, _changeset} ->
        json(conn, %{error: "Error: Cannot insert into database"})
    end
  end

  def redirect_url(conn, %{"redirect_url" => redirect_url}) do
    url = Repo.one(from l in Url.List,
                             where: l.shorten == ^redirect_url and
                               l.inserted_at >= ago(30, "day"),
                             limit: 1,
                             select: l.origin)
    case url do
      nil ->
        json(conn, %{error: "Not found"})
        _ ->
          redirect(conn, external: "http://" <> url)
    end
  end

  defp replace_url(url) do
    String.replace(url, ~r/https*:\/\//,"")
  end

  defp url_shortener(url) do
    url =
      Url.List
      |> last
      |> Repo.one
    latestID = Integer.to_string(url.id+1)
    Base.encode64(latestID)
  end
end
