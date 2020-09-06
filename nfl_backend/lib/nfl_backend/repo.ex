defmodule NflBackend.Repo do
  use Ecto.Repo,
    otp_app: :nfl_backend,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 50
end
