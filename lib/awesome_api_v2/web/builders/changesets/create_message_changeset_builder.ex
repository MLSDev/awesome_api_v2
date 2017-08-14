defmodule AwesomeApiV2.Web.Builders.Changesets.CreateMessageChangesetBuilder do
  alias AwesomeApiV2.Web.Message

  def build(current_user, chat, params \\ %{}) do
    %Message{}
      |> put_author_id(current_user.id)
      |> Ecto.Changeset.cast(params, [:text, :author_id])
      |> Ecto.Changeset.validate_length(:text, min: 1)
      |> generate_message_users(chat)
  end

  defp put_author_id(changeset, user_id), do: Ecto.Changeset.change(changeset, %{ author_id: user_id })

  #
  # RPIVATE METHODS
  #
  defp generate_message_users(changeset, chat) do
    case changeset do
      %Ecto.Changeset{ valid?: true } ->
        Ecto.Changeset.put_assoc(
          changeset,
          :message_users,
          (for user <- chat.users, do: Ecto.build_assoc(chat, :message_users, user_id: user.id)) # array of %MessageUser{}
        )
      _ -> changeset
    end
  end
end
