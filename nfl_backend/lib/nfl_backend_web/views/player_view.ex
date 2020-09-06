defmodule NflBackendWeb.PlayerView do
  use NflBackendWeb, :view
  alias NflBackendWeb.PlayerView

  defp add_pagination(player_data, data) do
    %{
      data: player_data,
      page_number: data.page_number, page_size: data.page_size,
      total_entries: data.total_entries, total_pages: data.total_pages
    }
  end

  def render("index.json", %{data: data}) do
    data.entries
    |> render_many(PlayerView, "player.json")
    |> add_pagination(data)
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, PlayerView, "player.json")}
  end

  def render("player.json", %{player: %{
      name: name, team: team, pos: pos, att: att, att_to_g: att_to_g,
      yds: yds, avg: avg, yds_to_g: yds_to_g, td: td, lng: lng,
      lng_has_t: lng_has_t, first: first, first_precent: first_precent,
      twenty_plus: twenty_plus, forty_plus: forty_plus, fum: fum
  }}) do
    lng = if lng_has_t do
      "#{lng}T"
    else
      to_string(lng)
    end
    %{
      "Player"=> name, "Team"=> team, "Pos"=> pos, "Att"=> att,
      "Att/G"=> att_to_g, "Yds"=> yds, "Avg"=> avg, "Yds/G"=> yds_to_g,
      "TD"=> td, "Lng"=> lng, "1st"=> first, "1st%"=> first_precent,
      "20+"=> twenty_plus, "40+"=> forty_plus, "FUM"=> fum
    }
  end
end
