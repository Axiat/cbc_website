defmodule ChurchWebsite.Repo.Migrations.GetRidOfG do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :g
    end

  end
end
