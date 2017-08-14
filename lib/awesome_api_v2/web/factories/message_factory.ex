defmodule AwesomeApiV2.Web.MessageFactory do
  import Logger

  @doc """
  ...
  """
  def create(conn, current_user, chat, message_params \\ %{}) do
    message_changeset = AwesomeApiV2.Web.Builders.Changesets.CreateMessageChangesetBuilder.build(current_user, chat, message_params)

    multi =
      Ecto.Multi.new                                 |>
      Ecto.Multi.insert(:message, message_changeset) |>
      Ecto.Multi.run(:send_message_to_socket, &send_message_to_socket(&1, chat, current_user))

    AwesomeApiV2.Repo.transaction multi
  end

  defp send_message_to_socket(%{ message: message }, chat, current_user) do
    for user <- chat.users do
      AwesomeApiV2.Web.Endpoint.broadcast! "users:#{ user.id }", "new:msg", %{
        chat_id: chat.id,
        message: %{
          id:      message.id,
          text:    message.text,
          status:  "sent",
          deleted: false, # by current_user, stores in MessageUser, supposed to be...
          author: %{
            id:       current_user.id,
            username: current_user.username,
            online:   current_user.online,
            avatar:   {} # is empty for a while
          }
        }
      }

      Logger.debug "==> message was sent to socket users:#{ user.id }"
    end

    { :ok, "ok" }
  end
end


# import Ecto.Query

# chat = AwesomeApiV2.Web.Chat |> where([chats], chats.id == ^2) |> preload([:users]) |> AwesomeApiV2.Repo.one!

# user = AwesomeApiV2.Web.User |> where([users], users.id == ^1) |> AwesomeApiV2.Repo.one!
