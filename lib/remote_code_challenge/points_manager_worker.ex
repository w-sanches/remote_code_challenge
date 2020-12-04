defmodule RemoteCodeChallenge.PointsManagerWorker do
  use GenServer
  alias RemoteCodeChallenge.PointsManager

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    PointsManager.update_user_points()
    Process.send_after(self(), :update_points, state.refresh_interval)

    {:ok, state}
  end

  @impl true
  def handle_info(:update_points, state) do
    PointsManager.update_user_points()
    Process.send_after(self(), :update_points, state.refresh_interval)

    {:noreply, PointsManager.update_max_number(state)}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  @impl true
  def handle_call(:fetch_users, _from, state) do
    users = PointsManager.fetch_users_above_limit(state.max_number)
    response = %{users: users, timestamp: state.timestamp}

    {:reply, response, PointsManager.update_timestamp(state)}
  end
end
