defmodule ChurchWebsite.UserController do
  use ChurchWebsite.Web, :controller

  alias ChurchWebsite.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end


  def show(conn, _params) do
    #user = Repo.get!(User, id)
    user = ChurchWebsite.Session.current_user(conn)
    render(conn, "show.html", user: user)
  end

  def edit(conn, _params) do
    #user = Repo.get!(User, id)
    user = ChurchWebsite.Session.current_user(conn)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User,id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show))
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
