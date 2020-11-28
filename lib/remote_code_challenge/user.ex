defmodule RemoteCodeChallenge.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  @required_attributes [:points]
  @derive {Jason.Encoder, only: [:id, :points]}

  schema "users" do
    field :points, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attributes)
    |> validate_required(@required_attributes)
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end

  def with_points_higher_than(limit) do
    from u in __MODULE__,
      where: u.points > ^limit,
      limit: 2
  end
end
