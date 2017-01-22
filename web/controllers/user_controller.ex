defmodule ChurchWebsite.UserController do
  use ChurchWebsite.Web, :controller

  alias ChurchWebsite.User

  def index(conn, _params) do
    if ChurchWebsite.Session.is_admin(conn) do
        users = Repo.all(User)
        render(conn, "index.html", users: users)
    else
        conn |> redirect(to: home_path(conn, :index))
    end

  end


  def show(conn, _params) do
    #user = Repo.get!(User, id)
    user = ChurchWebsite.Session.current_user(conn)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{ "id" => id}= _params) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do

    user = Repo.get!(User,id)
    changeset = User.changeset(user, user_params)
    %{"password" => password} = user_params

    case String.length(password) do
        0 -> update_repo(conn,user,changeset)
        _ -> update_repo(conn,user, change_password(changeset,ChurchWebsite.Repo) )
    end


  end

  import Ecto.Changeset, only: [put_change: 3]
  def change_password(changeset, repo) do
      changeset |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(changeset.params["password"]))
  end

  def update_repo(conn,user,changeset) do

     case Repo.update(changeset) do
         {:ok, _} ->
           if ChurchWebsite.Session.is_admin(conn) do
               conn
               |> put_flash(:info, "User updated successfully.")
               |> redirect(to: user_path(conn, :index))
           else
               conn
               |> put_flash(:info, "User updated successfully.")
               |> redirect(to: user_path(conn, :show))
           end
         {:error, changeset} ->
                render(conn, "edit.html", user: user, changeset: changeset)
       end


   end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

end
