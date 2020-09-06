defmodule NflBackend.Player do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  schema "players" do
    field :name, :string
    field :team, :string
    field :pos, :string
    field :att, :integer
    field :att_to_g, :float
    field :yds, :integer
    field :avg, :float
    field :yds_to_g, :float
    field :td, :integer
    field :lng, :integer
    field :lng_has_t, :boolean, default: false
    field :first, :integer
    field :first_precent, :float
    field :twenty_plus, :integer
    field :forty_plus, :integer
    field :fum, :integer

    timestamps()
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(player, attrs) do
    fields = [
      :name, :team, :pos, :att, :att_to_g, :yds, :avg,
      :yds_to_g, :td, :lng, :lng_has_t, :first, :first_precent,
      :twenty_plus, :forty_plus, :fum
    ]
    player
    |> cast(attrs, fields)
    |> validate_required(fields)
  end
end
