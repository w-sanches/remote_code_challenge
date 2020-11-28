defmodule RemoteCodeChallengeWeb.Router do
  use RemoteCodeChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RemoteCodeChallengeWeb do
    pipe_through :api
    get "/", UsersController, :index
  end
end
