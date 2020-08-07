defmodule VotingWeb.AuthAccessPipeline do
  @moduledoc """
  Guardian auth access pipe
  """
  use Guardian.Plug.Pipeline, otp_app: :voting

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
