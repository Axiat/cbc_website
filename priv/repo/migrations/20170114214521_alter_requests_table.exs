defmodule ChurchWebsite.Repo.Migrations.AlterRequestsTable do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      add :user_id, :integer
    end

  end
end
