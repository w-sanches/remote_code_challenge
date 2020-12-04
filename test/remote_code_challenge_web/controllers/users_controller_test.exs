defmodule RemoteCodeChallengeWeb.UsersControllerTest do
  use RemoteCodeChallengeWeb.ConnCase
  alias RemoteCodeChallenge.{Repo, User}

  describe "index/2" do
    test "resturns the expected structure", %{conn: conn} do
      response = get(conn, "/")

      assert json = json_response(response, 200)
      assert Map.has_key?(json, "timestamp")
      assert Map.has_key?(json, "users")
    end

    test "resturns at most two users", %{conn: conn} do
      response = get(conn, "/")

      0..100
      |> Enum.map(fn points ->
        %User{}
        |> User.changeset(%{points: points})
        |> Repo.insert!()
      end)

      assert json = json_response(response, 200)
      assert length(json["users"]) <= 2
    end
  end
end
