defmodule VotingWeb.Admin.SessionViewTest do
  use ExUnit.Case, async: true

  alias VotingWeb.Admin.SessionView

  import Voting.Factory

  test "render/2 returns ok and admin data" do
    admin = params_for(:admin, name: "Johnny")

    assert %{status: "ok", data: %{name: "Johnny"}} =
             SessionView.render("session.json", %{admin: admin})
  end
end
