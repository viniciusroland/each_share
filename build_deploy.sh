#!/bin/bash

# PORT=4000 _build/prod/rel/each_share/bin/each_share stop
kill `cat pid`
mix deps.get
mix ecto.create
mix ecto.migrate
elixir --detached -e "File.write! 'pid', :os.getpid" -S mix phx.server
# MIX_ENV=prod mix distillery.release
# PORT=4000 _build/prod/rel/each_share/bin/each_share start
