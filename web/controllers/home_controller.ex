defmodule ChurchWebsite.HomeController do
  use ChurchWebsite.Web, :controller

  alias ChurchWebsite.Repo
  alias ChurchWebsite.Request

    def index(conn, _params) do
        requests = Repo.all(Request)
        render(conn, "index.html", requests: requests)
     end
  
end