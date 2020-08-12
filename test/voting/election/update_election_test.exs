defmodule Voting.UpdateElectionTest do
  use Voting.DataCase, async: true

  alias Voting.{UpdateElection, Election}

  import Voting.Factory

  describe "run/1" do
    test "updates the election with given params" do
      admin = insert(:admin)
      election = insert(:election, created_by: admin)

      params = %{
        name: "New name",
        cover: "New cover",
        notice: "New notice"
      }

      assert {:ok, %Election{} = election} = UpdateElection.run(election, params)
      assert election.name == params.name
      assert election.cover == params.cover
      assert election.notice == params.notice
      assert election.created_by_id == admin.id
    end

    test "returns error when name is missing" do
      admin = insert(:admin)
      election = insert(:election, created_by: admin)

      params = %{name: ""}

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is missing" do
      admin = insert(:admin)
      election = insert(:election, created_by: admin)

      params = %{starts_at: ""}

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is missing" do
      admin = insert(:admin)
      election = insert(:election, created_by: admin)

      params = %{ends_at: ""}

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is greater than ends_at" do
      admin = insert(:admin)
      election = insert(:election, created_by: admin)

      params =
        params_for(:election,
          ends_at: ~U[2020-01-01 11:00:00Z],
          starts_at: ~U[2020-02-01 11:00:00Z]
        )

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end
  end
end
