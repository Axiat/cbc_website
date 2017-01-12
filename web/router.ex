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
    post    "/login",   SessionController,  :create
    delete  "/logout",  SessionController,  :delete


    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    get "/register", UserController, :new

    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChurchWebsite do
  #   pipe_through :api
  # end
end
