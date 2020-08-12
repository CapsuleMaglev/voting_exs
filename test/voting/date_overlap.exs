defmodule Voting.DateOverlapTest do
  use Voting.DataCase, async: true
  import Voting.Factory
  alias Voting.DateOverlap

  describe "validate_dates_overlap/3" do
    test "returns a valid changeset when dates don't overlap" do
      changeset =
        build(:election)
        |> Ecto.Changeset.change(%{
          starts_at: ~U[2020-01-01 11:00:00Z],
          ends_at: ~U[2020-03-01 11:00:00Z]
        })

      assert %Ecto.Changeset{valid?: true, errors: []} =
               DateOverlap.validate_dates_overlap(changeset, :starts_at, :ends_at)
    end

    test "returns a invalid changeset when dates overlap" do
      changeset =
        :election
        |> build()
        |> Ecto.Changeset.change(%{
          starts_at: ~U[2020-03-01 11:00:00Z],
          ends_at: ~U[2020-01-01 11:00:00Z]
        })

      assert %Ecto.Changeset{valid?: false} =
               changeset = DateOverlap.validate_dates_overlap(changeset, :starts_at, :ends_at)

      assert %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end

    test "returns a invalid changeset is already invalid" do
      changeset =
        :election
        |> build()
        |> Ecto.Changeset.change(%{name: ""})
        |> Ecto.Changeset.validate_required([:name])

      assert %Ecto.Changeset{valid?: false} =
               DateOverlap.validate_dates_overlap(changeset, :starts_at, :ends_at)
    end
  end
end
