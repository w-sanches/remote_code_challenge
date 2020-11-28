defmodule RemoteCodeChallenge.Repo do
  use Ecto.Repo,
    otp_app: :remote_code_challenge,
    adapter: Ecto.Adapters.Postgres
end
