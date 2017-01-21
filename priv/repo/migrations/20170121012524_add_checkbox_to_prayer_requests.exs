defmodule ChurchWebsite.Repo.Migrations.AddCheckboxToPrayerRequests do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      add :is_weekly, :boolean, default: false
    end
  end
end
