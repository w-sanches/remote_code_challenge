# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RemoteCodeChallenge.Repo.insert!(%RemoteCodeChallenge.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias RemoteCodeChallenge.{Repo, User}

Enum.each(1..100, fn _index ->
  %User{}
  |> User.changeset(%{points: 0})
  |> Repo.insert()
end)
