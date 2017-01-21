defmodule ChurchWebsite.Notifications do
  use ChurchWebsite.Web, :model

  schema "notifications" do
    field :message, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message])
    |> validate_required([:message])
  end
end
