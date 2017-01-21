defmodule ChurchWebsite.Session do
    alias ChurchWebsite.User

    def login(params, repo) do
      user = repo.get_by(User,email: String.downcase(params["email"]))
      case authenticate(user,params["password"]) do
        true  ->  {:ok, user}
        _     -> :error
      end
    end


    defp authenticate(user, password) do
      case user do
        nil ->  false
        _   ->  Comeonin.Bcrypt.checkpw(password, user.password_hash)
      end
    end


    def current_user(conn) do
      id = Plug.Conn.get_session(conn,:current_user)
      if id, do: ChurchWebsite.Repo.get(User, id)
    end

    def logged_in?(conn), do: !!current_user(conn)


    def access_requests(conn) do
      user = current_user(conn)
      case user.permissions do
        nil -> false
        _ -> true
      end
    end

    def is_admin(conn) do
      user = current_user(conn)
      case user.permissions do
        "admin" -> true
         _ -> false
      end
    end

  end
