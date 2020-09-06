defmodule NflBackend.Players do
  import Ecto.Query, warn: false
  alias NflBackend.Repo

  alias NflBackend.Player

  def list_players do
    from(p in Player)
  end

  def paginate(query, page, page_size) do
    Repo.paginate(query, page: page, page_size: page_size)
  end

  def all(query) do
    Repo.all(query)
  end

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  def sort_by(query, nil, nil) do
    query
  end

  def sort_by(query, nil, direction) do
    sort_by(query, "name", direction)
  end

  def sort_by(query, sort, nil) do
    sort_by(query, sort, "asc")
  end

  def sort_by(query, sort, direction) do
    attrs = [{
      String.to_existing_atom(direction),
      String.to_existing_atom(sort)
    }]
    order_by(query, ^attrs)
  end

  def filter_by_name(query, nil) do
    query
  end

  def filter_by_name(query, name) do
    where(query, [p], like(p.name, ^"%#{name}%"))
  end
end
