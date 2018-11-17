FROM elixir:1.7.4

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix archive.install hex phx_new 1.4.0

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix deps.get
EXPOSE 4000