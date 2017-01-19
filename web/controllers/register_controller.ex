defmodule ChurchWebsite.RegisterController do
    use ChurchWebsite.Web, :controller
    alias ChurchWebsite.User

    import Ecto.Changeset, only: [put_change: 3]

      def hash_password(changeset, repo) do
        changeset
        |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(changeset.params["password"]))
        |> repo.insert()
      end

    def create(conn, %{"user" => user_params}) do
        changeset = User.changeset(%User{}, user_params)

        case hash_password(changeset,ChurchWebsite.Repo) do
          {:ok, changeset} ->
            conn
            |> put_session(:current_user, changeset.id)
            |> put_session(:permissions, changeset.permissions)
            |> put_flash(:info, "User created successfully.")
            |> redirect(to: "/")
          {:error, changeset} ->
            conn
            |> put_flash(:info,"Unable to create account")
            |> render(conn, "new.html", changeset: changeset, params: user_params)
        end
      end


  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end



  
end