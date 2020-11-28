defmodule RemoteCodeChallengeWeb.UsersController do
  use RemoteCodeChallengeWeb, :controller

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    users = GenServer.call(RemoteCodeChallenge.PointsManager, :fetch_users)

    render(conn, :index, users: users)
  end
end
