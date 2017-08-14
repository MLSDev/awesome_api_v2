defmodule AwesomeApiV2.Web.Builders.Changesets.UpdateMessageChangesetBuilder do
#   def build(message, params \\ :empty) do
#     message
#       |> Ecto.Changeset.cast(params, permitted_params())
#       |> Ecto.Changeset.validate_length(:text, min: 1)
#   end

#   defp permitted_params do
#     [:text]
#   end
end
