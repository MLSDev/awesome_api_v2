defmodule AwesomeApiV2.Web.Builders.Changesets.UpdateSessionChangesetBuilder do
  def build(session, params \\ %{}) do
    Ecto.Changeset.cast session, params, [:push_token, :device_type]
  end
end
