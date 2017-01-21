defmodule ChurchWebsite.Repo.Migrations.ModifyPostModel do
  use Ecto.Migration
  use Timex

  def change do
    alter table(:posts) do
      remove :g
      add :date, :string
    end

  end
end
