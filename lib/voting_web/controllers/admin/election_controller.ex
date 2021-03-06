defmodule VotingWeb.Admin.ElectionController do
  use VotingWeb, :controller

  alias Voting.CreateElection
  alias VotingWeb.Guardian.Plug, as: GuardianPlug

  def create(conn, params) do
    admin = GuardianPlug.current_resource(conn)
    params = Map.put(params, "created_by_id", admin.id)

    case CreateElection.run(params) do
      {:ok, election} ->
        conn
        |> put_status(201)
        |> render("election.json", %{election: election})

      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
