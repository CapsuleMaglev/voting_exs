defmodule Voting.UpdateElection do
  @moduledoc """
  Update of election
  """
  import Ecto.Changeset
  import Voting.DateOverlap
  alias Voting.{Election, Repo}

  def run(%Election{} = election, params) do
    election
    |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at])
    |> validate_required([:name, :starts_at, :ends_at])
    |> validate_dates_overlap(:starts_at, :ends_at)
    |> foreign_key_constraint(:created_by_id)
    |> Repo.update()
  end
end
