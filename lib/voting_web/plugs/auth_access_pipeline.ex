defmodule VotingWeb.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :voting

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
