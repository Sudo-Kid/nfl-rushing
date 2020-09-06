defmodule NflBackend.PlayersTest do
  use NflBackend.DataCase

  alias NflBackend.Players

  describe "players" do
    alias NflBackend.Player

    @test_player %{
      name: "Joe Banyard",
      team: "JAX",
      pos: "RB",
      att: 2,
      att_to_g: 2,
      yds: 7,
      avg: 3.5,
      yds_to_g: 7,
      td: 0,
      lng: 7,
      lng_has_t: false,
      first: 0,
      first_precent: 0,
      twenty_plus: 0,
      forty_plus: 0,
      fum: 0
    }

    @invalid_player %{
      name: "Joe Banyard",
      team: "JAX",
      pos: "RB",
      att: 2,
      att_to_g: 2,
      yds: 7,
      avg: 3.5,
      yds_to_g: 7,
      td: 0,
      lng: "7",
      first: 0,
      first_precent: 0,
      twenty_plus: 0,
      forty_plus: 0,
      fum: nil
    }

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@test_player)
        |> Players.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Players.list_players() == [player]
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Players.create_player(@test_player)
      assert player.att == 2
      assert player.name == "Joe Banyard"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Players.create_player(@invalid_player)
    end
  end
end
