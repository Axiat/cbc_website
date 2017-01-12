defmodule ChurchWebsite.RegisterController do
    use ChurchWebsite.Web, :controller
    alias ChurchWebsite.User

    import Ecto.Changeset, only: [put_change: 3]

      def create(changeset, repo) do
        changeset
        |> put_change(:password_hash, hashed_password(changeset.params["password"]))
        |> repo.insert()
      end

      defp hashed_password(password) do
          Comeonin.Bcrypt.hashpwsalt(password) # hash password
      end


#    def create(conn, %{"user" => user_params}) do
#        changeset = User.changeset(%User{}, user_params)
#
#        case create(changeset,ChurchWebsite.Repo) do
#          {:ok, changeset} ->
#            conn
#            |> put_flash(:info, "User created successfully.")
#            |> redirect(to: home_path(conn, :index))
#          {:error, changeset} ->
#            conn
#            |> put_flash(:info,"Unable to create account")
#            |> render(conn, "new.html", changeset: changeset)
#        end
#      end
#
#
#  def new(conn, _params) do
#    changeset = User.changeset(%User{})
#    render(conn, "new.html", changeset: changeset)
#  end



  
end