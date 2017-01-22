defmodule ChurchWebsite.Request do
  use ChurchWebsite.Web, :model

  schema "requests" do
    field :first_name, :string
    field :last_name, :string
    field :date, :string
    field :body, :string
    field :user_id, :integer
    field :is_weekly, :boolean, default: false
    field :is_urgent, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :date, :user_id,:is_weekly, :is_urgent, :body])
    |> validate_required([:body])
  end

  @doc """
  The function which is called to sort the prayer requests by last name
  """
  def ordered_non_weekly(query) do
    from t in query,
      order_by: t.last_name
  end

  def ordered_weekly(query) do
    from t in query,
        where: t.is_weekly == true,
        order_by: t.last_name
  end

  def urgent_requests(query) do
    from t in query,
        where: t.is_urgent == true
  end
end
