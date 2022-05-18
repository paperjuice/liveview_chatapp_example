defmodule CourseWeb.Router do

  alias CourseWeb.Plugs.AddCurrentUser

  use CourseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CourseWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AddCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug CourseWeb.Plugs.CheckAuth
  end

  scope "/", CourseWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    get "/signup", UserController, :signup_form
    post "/signup/new", UserController, :signup

    get "/login", UserController, :login_form
    post"/login", UserController, :login

    delete "/logout", UserController, :logout
  end

  scope "/", CourseWeb do
    pipe_through [:browser, :auth]

    live "/messaging", MessagingLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", CourseWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CourseWeb.Telemetry
    end
  end
end
