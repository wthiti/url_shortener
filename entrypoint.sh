#!/bin/sh

mix ecto.create
mix ecto.migrate
mix phx.server