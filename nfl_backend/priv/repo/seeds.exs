# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflBackend.Repo.insert!(%NflBackend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if NflBackend.Players.list_players() |> NflBackend.Players.all() == [] do
  "./rushing.json"
  |> File.read!()
  |> Jason.decode!()
  |> Enum.map(fn player ->
    %{
      "Player"=> name, "Team"=> team, "Pos"=> pos, "Att"=> att,
      "Att/G"=> att_to_g, "Yds"=> yds, "Avg"=> avg, "Yds/G"=> yds_to_g,
      "TD"=> td, "Lng"=> lng, "1st"=> first, "1st%"=> first_precent,
      "20+"=> twenty_plus, "40+"=> forty_plus, "FUM"=> fum
    } = player
    yds = if not is_integer(yds) do
      {yds, _} =
        yds
        |> String.replace(",", "")
        |> Integer.parse()
      yds
    else
        yds
    end
    {lng, lng_has_t} = if not is_integer(lng) do
      {lng, t} =
        lng
        |> Integer.parse()
      {lng, t != ""}
    else
      {lng, false}
    end
    %{
      name: name, team: team, pos: pos, att: att, att_to_g: att_to_g,
      yds: yds, avg: avg, yds_to_g: yds_to_g, td: td, lng: lng,
      lng_has_t: lng_has_t, first: first, first_precent: first_precent,
      twenty_plus: twenty_plus, forty_plus: forty_plus, fum: fum
    }
    |> NflBackend.Player.changeset()
    |> NflBackend.Repo.insert!()
  end)
end
