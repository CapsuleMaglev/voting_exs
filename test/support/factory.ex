defmodule Voting.Factory do
  @moduledoc """
  Factories for tests
  """
  # with Ecto
  use ExMachina.Ecto, repo: Voting.Repo

  def admin_factory do
    %Voting.Admin{
      name: "Jane Smith",
      email: "email@example.com",
      password_hash: Bcrypt.hash_pwd_salt("123456")
    }
  end

  def election_factory do
    %Voting.Election{
      name: "Election 2020",
      cover: "http-image",
      notice: "http-pdf",
      starts_at: ~U[2020-01-01 11:00:00Z],
      ends_at: ~U[2020-02-01 11:00:00Z],
      created_by: build(:admin)
    }
  end
end
