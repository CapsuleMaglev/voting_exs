defmodule Voting.CreateElectionTest do
  use Voting.DataCase, async: true

  alias Voting.{Election, CreateElection}

  import Voting.Factory

  describe "run/1" do
    test "returns a struct when the params are valid" do
      admin = insert(:admin)
      params = params_for(:election, created_by_id: admin.id)
      assert {:ok, %Election{} = election} = CreateElection.run(params)
      assert election.name == params.name
      assert election.cover == params.cover
      assert election.notice == params.notice
      assert election.starts_at == params.starts_at
      assert election.ends_at == params.ends_at
      assert election.created_by_id == admin.id
    end

    test "returns error when name is missing" do
      admin = insert(:admin)
      params = params_for(:election, name: "", created_by_id: admin.id)
      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is missing" do
      admin = insert(:admin)
      params = params_for(:election, starts_at: nil, created_by_id: admin.id)
      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is missing" do
      admin = insert(:admin)
      params = params_for(:election, ends_at: nil, created_by_id: admin.id)
      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is greater than ends_at" do
      admin = insert(:admin)

      params =
        params_for(:election,
          ends_at: ~U[2020-01-01 11:00:00Z],
          starts_at: ~U[2020-02-01 11:00:00Z],
          created_by_id: admin.id
        )

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end
  end
end
