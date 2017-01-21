defmodule ChurchWebsite.Repo.Migrations.RemoveGField do
  use Ecto.Migration

  def change do
    drop table(:posts)

  end
end
