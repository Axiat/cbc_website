import Joken
defmodule ChurchWebsite.User do
  use ChurchWebsite.Web, :model

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :email, :string
    field :lastname, :string
    field :permissions, :string
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :lastname ,:password, :permissions, :email])
    |> validate_required([:name, :lastname, :email,]) # email is optional
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_length(:lastname, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
    else
      changeset
    end
  end

  def generate_token(user) do
    %{user_id: user.id}
    |> token
    |> with_signer(hs256("secret-change-me"))
    |> sign
    |> get_compact
  end


end
