defmodule ChurchWebsite.HelloController do
  use ChurchWebsite.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"messenger" => messenger}) do
    if messenger == "hello" do
      render conn, "show.html", messenger: "blah"
    end
    render conn, "show.html", messenger: messenger
  end

  
end