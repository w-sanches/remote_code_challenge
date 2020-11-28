defmodule RemoteCodeChallengeWeb.UsersView do
  def render("index.json", %{users: users}), do: users
end
