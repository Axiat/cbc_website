defmodule ChurchWebsite.Router do
  use ChurchWebsite.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChurchWebsite do
    pipe_through :browser # Use the default browser stack

    get     "/",        HomeController,     :index

    get     "/login",   SessionController,  :new
    post    "/login",   SessionController,  :login
    delete  "/logout",  SessionController,  :delete
    get     "/change_password", SessionController, :display_reset_password
    post    "/change_password", SessionController, :reset_password

    get     "/register",RegisterController, :new
    post    "/register",RegisterController, :create


    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    get "/prayer_requests", RequestController, :users_view
    get "/permissions/:input", RequestController, :permissions
    get "/permissions",     RequestController, :show_permissions


    get "/about",   PageController, :about
    get "/history", PageController, :history
    get "/pastor",  PageController, :pastor
    get "/pastor_assistant",    PageController,     :pastor_assistant
    get "/contact",             PageController,     :contact
    get "/ministries/children", PageController,     :children
    get "/ministries/teens",    PageController,     :teens
    get "/ministries/adults",   PageController,     :adults

    get "/user/show", UserController, :show
    get "/user/edit", UserController, :edit

    get "/users/all", UserController, :index;

    resources "/users", UserController
    resources "/requests", RequestController
    resources "/notifications", NotificationsController


  end

  # Other scopes may use custom stacks.
  # scope "/api", ChurchWebsite do
  #   pipe_through :api
  # end
end
