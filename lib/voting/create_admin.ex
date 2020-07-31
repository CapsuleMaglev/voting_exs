defmodule Voting.CreateAdmin do
  @moduledoc """
  Creating new admin
  """

  import Ecto.Changeset
  alias Voting.{Admin, Repo}

  # @doc false
  # def changeset(admin, attrs) do
  #   admin
  #   |> cast(attrs, [:name, :email, :password_hash])
  #   |> validate_required([:name, :email, :password_hash])
  # end

  def run(params) do
    %Admin{}
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_password()
    |> Repo.insert()
  end

  # pattern matching
  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset

  # usando case
  # defp put_password(changeset) do
  #   case %Ecto.Changeset{valid?: true} do
  #     true ->
  #       put_change(changeset, :password_hash, encrypt(get_change(changeset, :password)))

  #     false ->
  #       changeset
  #   end
  # end
end
