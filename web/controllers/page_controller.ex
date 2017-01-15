defmodule ChurchWebsite.PageController do
  use ChurchWebsite.Web, :controller

  def about(conn, _params) do
    render conn, "about.html"
  end

  def history(conn, _params) do
      render conn, "history.html"
  end


   def pastor(conn, _params) do
      render conn, "pastor.html"
   end


   def pastor_assistant(conn, _params) do
       render conn, "pastor_assistant.html"
   end

   def contact(conn, _params) do
     render conn, "contact.html"
   end



end