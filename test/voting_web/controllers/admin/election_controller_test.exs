defmodule VotingWeb.Admin.ElectionControllerTest do
  use VotingWeb.ConnCase, async: true

  import Voting.Factory
  import VotingWeb.AdminAuth

  describe "create/2" do
    setup %{conn: conn} do
      conn = authenticate(conn)
      %{conn: conn}
    end

    test "returns 201 when election is created", %{conn: conn} do
      params = params_for(:election)

      conn = post(conn, "api/v1/elections", params)
      assert %{"status" => "ok", "data" => _} = json_response(conn, 201)
    end

    test "returns 402 when params are invalid", %{conn: conn} do
      params = params_for(:election, name: "")

      conn = post(conn, "api/v1/elections", params)
      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end
end
