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


   def children(conn, _params) do
      render conn, "children.html"
   end

   def teens(conn, _params) do
     render conn, "teens.html"
   end

   def adults(conn, _params) do
     render conn, "adults.html"
   end



end