defmodule AwesomeApiV2.Web.Builders.Changesets.AuthToken.CreateChangesetBuilder do
  @moduledoc """
    Module that is dedicated to build create changeset for AuthToken (Session) model
  """

  @shortdoc "AuthToken create changeset builder"

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def build(params \\ %{}) do
    %AwesomeApiV2.Web.AuthToken{}
    |> Ecto.Changeset.cast(params, [:push_token, :device_type])
    |> Ecto.Changeset.put_change(:value, SecureRandom.urlsafe_base64())
  end
end
