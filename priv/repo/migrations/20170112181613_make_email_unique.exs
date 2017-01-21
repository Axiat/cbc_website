defmodule ChurchWebsite.Repo.Migrations.MakeEmailUnique do
  use Ecto.Migration

  def change do
    alter table(:users) do

      modify :password, :string, virtual: true
      add :password_hash, :string

    end
    create unique_index(:users, [:email])

  end
end
