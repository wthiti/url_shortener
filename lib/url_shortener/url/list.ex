defmodule UrlShortener.Url.List do
  use Ecto.Schema
  import Ecto.Changeset


  schema "url_list" do
    field :origin, :string
    field :shorten, :string

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:shorten, :origin])
    |> validate_required([:shorten, :origin])
  end
end
