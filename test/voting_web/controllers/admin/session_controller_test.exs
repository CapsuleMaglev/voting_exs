defmodule VotingWeb.Admin.SessionControllerTest do
  use VotingWeb.ConnCase, async: true

  import Voting.Factory

  describe "create/2" do
    setup %{conn: conn} do
      insert(:admin, email: "johnny@email.com", name: "Johnny")
      %{conn: conn}
    end

    test "returns 200 when admin credentials are valid", %{conn: conn} do
      conn =
        post(conn, "api/v1/admin/sign_in", %{
          "email" => "johnny@email.com",
          "password" => "123456"
        })

      assert %{"status" => "ok", "data" => %{"name" => "Johnny", "token" => _}} =
               json_response(conn, 200)
    end

    test "returns 401 when admin credentials are valid", %{conn: conn} do
      conn =
        post(conn, "api/v1/admin/sign_in", %{"email" => "johnny@email.com", "password" => "123"})

      assert %{"status" => "unathorized"} = json_response(conn, 401)
    end
  end
end
