defmodule RemoteCodeChallenge.PointsManager do
  use GenServer
  alias RemoteCodeChallenge.{Repo, User}
  @interval 60_000

  def start_link(_) do
    initial_state = %{max_number: Enum.random(0..100), timestamp: nil}

    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    do_update_points()
    Process.send_after(self(), :update_points, @interval)

    {:ok, state}
  end

  @impl true
  def handle_info(:update_points, state) do
    do_update_points()
    Process.send_after(self(), :update_points, @interval)

    {:noreply, %{state | max_number: Enum.random(0..100)}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  @impl true
  def handle_call(:fetch_users, _from, state) do
    users =
      state.max_number
      |> User.with_points_higher_than()
      |> Repo.all()

    response = %{users: users, timestamp: state.timestamp}

    {:reply, response, %{state | timestamp: NaiveDateTime.local_now()}}
  end

  defp do_update_points() do
    User
    |> Repo.all()
    |> Enum.each(fn user ->
      user
      |> User.changeset(%{points: Enum.random(0..100)})
      |> Repo.update()
    end)
  end
end
