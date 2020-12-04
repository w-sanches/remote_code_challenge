defmodule RemoteCodeChallenge.PointsManagerTest do
  use RemoteCodeChallenge.DataCase
  alias RemoteCodeChallenge.{PointsManager, Repo, User}

  describe "fetch_users_above_limit/1" do
    test "returns users with more points than a given limit" do
      limit = 8

      users =
        1..10
        |> Enum.map(fn points ->
          %User{}
          |> User.changeset(%{points: points})
          |> Repo.insert!()
        end)
        |> Enum.filter(fn user -> user.points > limit end)

      assert PointsManager.fetch_users_above_limit(limit) == users
    end

    test "returns at most two users" do
      limit = 5

      users =
        1..10
        |> Enum.map(fn points ->
          %User{}
          |> User.changeset(%{points: points})
          |> Repo.insert!()
        end)
        |> Enum.filter(fn user -> user.points > limit end)
        |> Enum.take(2)

      assert PointsManager.fetch_users_above_limit(limit) == users
    end
  end

  describe "update_max_number/1" do
    test "returns a state with a new max_number" do
      initial_state = %{max_number: -1, refresh_interval: 60_000, timestamp: nil}
      new_state = PointsManager.update_max_number(initial_state)

      refute new_state.max_number == initial_state.max_number
    end
  end

  describe "update_user_points/0" do
    test "modifies current users points" do
      user_points =
        1..10
        |> Enum.map(fn points ->
          %User{}
          |> User.changeset(%{points: points})
          |> Repo.insert!()
        end)
        |> Enum.map(fn user -> user.points end)

      PointsManager.update_user_points()

      new_user_points =
        User
        |> Repo.all()
        |> Enum.map(fn user -> user.points end)

      refute user_points == new_user_points
    end
  end

  describe "update_timestamp/1" do
    test "returns a state with a timestamp greater than the previous" do
      initial_state = %{
        max_number: -1,
        refresh_interval: 60_000,
        timestamp: NaiveDateTime.from_iso8601!("1999-01-01 00:00:00")
      }

      new_state = PointsManager.update_timestamp(initial_state)

      assert NaiveDateTime.compare(new_state.timestamp, initial_state.timestamp) == :gt
    end
  end
end
