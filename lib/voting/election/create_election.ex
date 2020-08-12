defmodule Voting.CreateElection do
  @moduledoc """
  Creation of election
  """
  import Ecto.Changeset
  import Voting.DateOverlap
  alias Voting.{Election, Repo}

  # def run(%{"admin" => admin} = params) do
  #   %Election{}
  #   |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at])
  #   |> validate_required([:name, :starts_at, :ends_at])
  #   |> put_assoc(:created_by, admin)
  #   |> Repo.insert()
  # end

  # ou
  def run(params) do
    %Election{}
    |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at, :created_by_id])
    |> validate_required([:name, :starts_at, :ends_at, :created_by_id])
    |> validate_dates_overlap(:starts_at, :ends_at)
    |> foreign_key_constraint(:created_by_id)
    |> Repo.insert()
  end
end
