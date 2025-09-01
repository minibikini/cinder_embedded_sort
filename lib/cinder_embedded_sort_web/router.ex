defmodule CinderEmbeddedSortWeb.Router do
  use CinderEmbeddedSortWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CinderEmbeddedSortWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CinderEmbeddedSortWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/my_resources", MyResourceLive.Index, :index
    live "/my_resources/new", MyResourceLive.Form, :new
    live "/my_resources/:id/edit", MyResourceLive.Form, :edit

    live "/my_resources/:id", MyResourceLive.Show, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", CinderEmbeddedSortWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:cinder_embedded_sort, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CinderEmbeddedSortWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
