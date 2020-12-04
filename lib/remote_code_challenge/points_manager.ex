defmodule RemoteCodeChallenge.PointsManager do
  alias RemoteCodeChallenge.{Repo, User}

  def fetch_users_above_limit(limit) do
    limit
    |> User.with_points_higher_than()
    |> Repo.all()
  end

  def update_max_number(state) do
    %{state | max_number: Enum.random(0..100)}
  end

  def update_timestamp(state) do
    %{state | timestamp: NaiveDateTime.local_now()}
  end

  def update_user_points() do
    User
    |> Repo.all()
    |> Enum.each(fn user ->
      user
      |> User.changeset(%{points: Enum.random(0..100)})
      |> Repo.update()
    end)
  end
end
