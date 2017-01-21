defmodule ChurchWebsite.HomeController do
  use ChurchWebsite.Web, :controller

  alias ChurchWebsite.Repo
  alias ChurchWebsite.Request
  alias ChurchWebsite.Notifications

    def index(conn, _params) do
        requests = Repo.all(Request)
        notifications = Repo.all(Notifications)

        render(conn, "index.html",
            requests: requests,
            notifications: notifications,
            user: ChurchWebsite.Session.current_user(conn),
            layout: {ChurchWebsite.LayoutView, "main_page_layout.html"})
     end

  
end