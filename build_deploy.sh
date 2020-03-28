#!/bin/bash

mix deps.get
mix ecto.create
mix ecto.migrate
MIX_ENV=prod mix distillery.release
PORT=4000 _build/prod/rel/each_share/bin/each_share start

