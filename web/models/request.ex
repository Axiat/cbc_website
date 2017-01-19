defmodule ChurchWebsite.Request do
  use ChurchWebsite.Web, :model

  schema "requests" do
    field :first_name, :string
    field :last_name, :string
    field :date, :string
    field :body, :string
    field :user_id, :integer
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :date, :user_id, :body])
    |> validate_required([:body])
  end

  @doc """
  The function which is called to sort the prayer requests by last name
  """
  def ordered(query) do
    from t in query,
      order_by: t.last_name
  end
end
