defmodule RemoteCodeChallengeWeb.Router do
  use RemoteCodeChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RemoteCodeChallengeWeb do
    pipe_through :api
  end
end
