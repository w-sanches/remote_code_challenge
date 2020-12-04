# RemoteCodeChallenge

To start your server:

  * Start postgres database with `docker-compose up -d postgres` or setup your own running on port `5432` without docker
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints
The server contains a single endpoint:

### `GET localhost:4000/`
This returns at most two users with points higher than a random hidden number and a timestamp showing when the previous call to the endpoint happened.
Example response:
```elixir
{
  'users': [{id: 1, points: 30}, {id: 72, points: 30}],
  'timestamp': `2020-07-30 17:09:33`
}
```