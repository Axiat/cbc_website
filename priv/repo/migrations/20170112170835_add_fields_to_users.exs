defmodule ChurchWebsite.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
       add :lastname, :string
       add :permissions, :string
    end

  end
end
