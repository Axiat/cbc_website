defmodule ChurchWebsite.HomeController do
  use ChurchWebsite.Web, :controller

  alias ChurchWebsite.Repo
  alias ChurchWebsite.Request

    def index(conn, _params) do
        requests = Repo.all(Request)
        render(conn, "index.html", requests: requests,
                layout: {ChurchWebsite.LayoutView, "main_page_layout.html"})
     end


     def about(conn, _params) do
         render "about.html"
     end
  
end