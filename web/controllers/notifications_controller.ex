defmodule ChurchWebsite.NotificationsController do
  use ChurchWebsite.Web, :controller

  alias ChurchWebsite.Notifications

  def index(conn, _params) do
    notifications = Repo.all(Notifications)
    render(conn, "index.html", notifications: notifications)
  end

  def new(conn, _params) do
    changeset = Notifications.changeset(%Notifications{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"notifications" => notifications_params}) do
    changeset = Notifications.changeset(%Notifications{}, notifications_params)

    case Repo.insert(changeset) do
      {:ok, _notifications} ->
        conn
        |> put_flash(:info, "Notifications created successfully.")
        |> redirect(to: notifications_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    notifications = Repo.get!(Notifications, id)
    render(conn, "show.html", notifications: notifications)
  end

  def edit(conn, %{"id" => id}) do
    notifications = Repo.get!(Notifications, id)
    changeset = Notifications.changeset(notifications)
    render(conn, "edit.html", notifications: notifications, changeset: changeset)
  end

  def update(conn, %{"id" => id, "notifications" => notifications_params}) do
    notifications = Repo.get!(Notifications, id)
    changeset = Notifications.changeset(notifications, notifications_params)

    case Repo.update(changeset) do
      {:ok, notifications} ->
        conn
        |> put_flash(:info, "Notifications updated successfully.")
        |> redirect(to: notifications_path(conn, :show, notifications))
      {:error, changeset} ->
        render(conn, "edit.html", notifications: notifications, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    notifications = Repo.get!(Notifications, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(notifications)

    conn
    |> put_flash(:info, "Notifications deleted successfully.")
    |> redirect(to: notifications_path(conn, :index))
  end
end
