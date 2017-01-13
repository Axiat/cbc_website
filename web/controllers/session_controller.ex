defmodule ChurchWebsite.SessionController do
  use ChurchWebsite.Web, :controller


  def new(conn, _params) do
    render conn, "new.html"
  end


  def login(conn, %{"session" => session_params}) do
    case ChurchWebsite.Session.login(session_params, ChurchWebsite.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user,user.id)
        |> put_session(:permissions, user.permissions)
        |> redirect(to: "/")
       :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end


  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end


  
end