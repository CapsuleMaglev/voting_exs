defmodule VotingWeb.AdminAuth do
  @moduledoc """
  Authenticate requests as admin
  """

  alias VotingWeb.Guardian

  import Voting.Factory
  import Plug.Conn

  def authenticate(conn, admin \\ insert(:admin)) do
    {:ok, token, _} = Guardian.encode_and_sign(admin)

    put_req_header(conn, "authorization", "Bearer " <> token)
  end
end
