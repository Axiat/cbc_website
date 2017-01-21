defmodule ChurchWebsite.RequestController do
  use ChurchWebsite.Web, :controller
  use Timex

  alias ChurchWebsite.Request
  alias ChurchWebsite.Repo
  alias ChurchWebsite.User
  alias ChurchWebsite.Session

  def index(conn, _params) do
    requests = Repo.all(Request)
    render(conn, "index.html", requests: requests)
  end

  @doc """
      This function creates the default page where everyone can see prayer requests
  """
  def users_view(conn, _params) do

     if Session.access_requests(conn) do

        non_weekly_requests = Request |> Request.ordered_non_weekly() |> Repo.all()
        weekly_requests = Request |> Request.ordered_weekly() |> Repo.all()

        render(conn, "users_view.html", non_weekly_requests: non_weekly_requests, weekly_requests: weekly_requests,
        layout: {ChurchWebsite.LayoutView, "main_page_layout.html"})

     else
        redirect(conn,to: home_path(conn, :index))

     end

  end

  def new(conn, _params) do
    user = ChurchWebsite.Session.current_user(conn)
    current_date = Timex.today()
    changeset = Request.changeset(%Request{first_name: user.name, last_name: user.lastname, date: current_date, user_id: user.id })
    render(conn, "new.html", %{changeset: changeset, conn: conn})
  end

  def create(conn, %{"request" => request_params}) do
    changeset = Request.changeset(%Request{}, request_params)

    case Repo.insert(changeset) do
      {:ok, _request} ->
        conn
        |> put_flash(:info, "Request created successfully.")
        |> redirect(to: request_path(conn, :users_view))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    request = Repo.get!(Request, id)
    render(conn, "show.html", request: request)
  end

  def edit(conn, %{"id" => id}) do
    request = Repo.get!(Request, id)
    changeset = Request.changeset(request)
    render(conn, "edit.html", request: request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "request" => request_params}) do
    request = Repo.get!(Request, id)
    changeset = Request.changeset(request, request_params)

    case Repo.update(changeset) do
      {:ok, _ } ->
        conn
        |> put_flash(:info, "Request updated successfully.")
        |> redirect(to: "/prayer_requests")
      {:error, changeset} ->
        render(conn, "edit.html", request: request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    request = Repo.get!(Request, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(request)

    conn
    |> put_flash(:info, "Request deleted successfully.")
    |> redirect(to: request_path(conn, :users_view))
  end


    def show_permissions(conn, _params ) do
        user = ChurchWebsite.Session.current_user(conn)
        changeset = User.changeset(user)
        render conn, "show_permissions.html", user: user, changeset: changeset
    end



    def permissions(conn, %{"input" => input} = _params) do
        case input do
            "pastor" -> update_permissions(conn,"admin")
            "person" -> update_permissions(conn,"level 1")
             _  ->   render conn, "permissions.html"
        end
   end



   def update_permissions(conn, permission) do

      id = Plug.Conn.get_session(conn,:current_user)
      user = Repo.get!(User,id)
      user_params = %{permissions: permission}
      changeset = User.changeset(user, user_params)

      case Repo.update(changeset) do
        {:ok, _ } ->
          conn
          |> put_flash(:info, "Permissions updated successfully.")
          |> redirect(to: request_path(conn, :users_view))
        {:error, _ } ->
            render(conn, "permissions.html")
      end

   end



end
