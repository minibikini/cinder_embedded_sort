An attempt to reproduce the error with Cider and embedded resources sorting (filter works just fine). See the [discussion](https://discord.com/channels/711271361523351632/1391786417348415559/1411834296184078336) on the Ash Discord for the context.

- Run `mix setup` to install, setup dependencies and seed the SQLite database

- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

- Open [http://localhost:4000/my_resources](http://localhost:4000/my_resources) and try to sort.
