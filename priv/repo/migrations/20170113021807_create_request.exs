defmodule ChurchWebsite.Repo.Migrations.CreateRequest do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :first_name, :string
      add :last_name, :string
      add :date, :string
      add :body, :text

      timestamps()
    end

  end
end
