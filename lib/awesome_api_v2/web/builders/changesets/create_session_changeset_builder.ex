# defmodule AwesomeApiV2.Web.Builders.Changesets.CreateSessionChangesetBuilder do
#   def build_from_user(user) do
#     %AwesomeApiV2.Web.AuthToken{}
#     |> Ecto.Changeset.changeset(%{})
#     |> Ecto.Changeset.put_change(:user_id, user.id)
#     |> Ecto.Changeset.put_change(:value, SecureRandom.urlsafe_base64())
#   end
# end
