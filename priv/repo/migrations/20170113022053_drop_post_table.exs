defmodule ChurchWebsite.Repo.Migrations.DropPostTable do
  use Ecto.Migration

  def change do
    drop table(:posts)

  end
end
