defmodule UrlShortener.Repo.Migrations.CreateUrlList do
  use Ecto.Migration

  def change do
    create table(:url_list) do
      add :shorten, :string
      add :origin, :string

      timestamps()
    end

  end
end
