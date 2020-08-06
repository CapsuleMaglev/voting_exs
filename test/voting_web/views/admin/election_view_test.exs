defmodule VotingWeb.Admin.ElectionViewTest do
  use ExUnit.Case, async: true

  alias VotingWeb.Admin.ElectionView

  import Voting.Factory

  test "render/2 returns ok and election data" do
    election = build(:election, name: "New Election", id: 1)

    assert %{status: "ok", data: election} =
             ElectionView.render("election.json", %{election: election})
  end
end
