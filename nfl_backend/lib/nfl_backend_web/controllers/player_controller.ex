defmodule NflBackendWeb.PlayerController do
  use NflBackendWeb, :controller

  alias NflBackend.Players

  action_fallback NflBackendWeb.FallbackController

  def index(conn, params) do
    page = Map.get(params, "page", 1)
    page_size = Map.get(params, "page_size", 50)

    players =
      params
      |> get_players()
      |> Players.paginate(page, page_size)

    render(conn, "index.json", data: players)
  end

  def csv(conn, params) do
    csv_file =
      params
      |> get_players()
      |> Players.all()
      |> to_csv()

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"players.csv\"")
    |> send_resp(200, csv_file)
  end

  defp get_players(params) do
    sort_by = Map.get(params, "sort_by", nil)
    sort_direction = Map.get(params, "sort_direction", nil)
    filter = Map.get(params, "filter", nil)

    Players.list_players()
    |> Players.sort_by(sort_by, sort_direction)
    |> Players.filter_by_name(filter)
  end

  defp to_csv(data) do
    "Player,Team Pos,Att,Att/G,Yds,Avg,Yds/G,TD,Lng,1st,1st%,20+,40+,FUM\n"
    |> to_csv(data)
  end

  defp to_csv(csv_file, []) do
    csv_file
  end

  defp to_csv(csv_file, [player|t]) do
    lng = if player.lng_has_t do
      "#{player.lng}T"
    else
      to_string(player.lng)
    end
    # Thought about automating this but didn't seem worth the time
    [
      csv_file, player.name, ",", player.team, ",", player.pos, ",",
      to_string(player.att), ",", to_string(player.att_to_g), ",",
      to_string(player.yds), ",", to_string(player.avg), ",",
      to_string(player.yds_to_g), ",", to_string(player.td), ",", lng, ",",
      to_string(player.first), ",", to_string(player.first_precent), ",",
      to_string(player.twenty_plus), ",", to_string(player.forty_plus), ",",
      to_string(player.fum), "\n"
    ]
    |> to_csv(t)
  end
end
