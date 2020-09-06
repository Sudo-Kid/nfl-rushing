defmodule NflBackend.Repo.Migrations.AddPlayer do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION citext", "DROP EXTENSION citext"

    create table("players") do
      add :name, :citext, null: false
      add :team, :citext, null: false
      add :pos, :string, null: false
      add :att, :integer, null: false
      add :att_to_g, :float, null: false
      add :yds, :integer, null: false
      add :avg, :float, null: false
      add :yds_to_g, :float, null: false
      add :td, :integer, null: false
      add :lng, :integer, null: false
      add :lng_has_t, :boolean, default: false, null: false
      add :first, :integer, null: false
      add :first_precent, :float, null: false
      add :twenty_plus, :integer, null: false
      add :forty_plus, :integer, null: false
      add :fum, :integer, null: false

      timestamps(type: :utc_datetime_usec)
    end
  end
end
