defmodule TodoMVCWeb.Router do
  use TodoMVCWeb, :router
  # use LiveGenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoMVCWeb do
    pipe_through :browser

    live "/", MainLive, layout: {TodoMVCWeb.LayoutView, :root}
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoMVCWeb do
  #   pipe_through :api
  # end
end
