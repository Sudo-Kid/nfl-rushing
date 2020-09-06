FROM elixir:1.9.4-slim

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN mkdir /app
WORKDIR /app

# Install hex package manager
ENV MIX_ENV="$MIX_ENV"
RUN mix local.rebar --force
RUN mix local.hex --force
COPY mix.exs .
RUN mix deps.get

ENV SECRET_KEY_BASE="$SECRET_KEY_BASE"
ENV PGUSER="$PGUSER"
ENV PGPASSWORD="$PGPASSWORD"
ENV PGDATABASE="$PGDATABASE"
ENV PGPORT="$PGPORT"
ENV PGHOST="$PGHOST"


# Compile the project
COPY . /app
RUN MIX_ENV=prod mix compile && chmod +x entrypoint.sh

CMD ["/app/entrypoint.sh"]
