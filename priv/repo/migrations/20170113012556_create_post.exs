defmodule ChurchWebsite.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :first_name, :string
      add :last_name, :string
      add :g, :string
      add :date, :string
      add :body, :text

      timestamps()
    end

  end
end
