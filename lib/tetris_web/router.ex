defmodule TetrisWeb.Router do
  use TetrisWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TetrisWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/tetris", TetrisLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", TetrisWeb do
  #   pipe_through :api
  # end
end
