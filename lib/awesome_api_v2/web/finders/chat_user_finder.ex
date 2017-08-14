defmodule AwesomeApiV2.Web.Finders.ChatUserFinder do
  import Ecto.Query

  def find_user_chat_by(chat_id, user_id) do
    AwesomeApiV2.Web.ChatUser                             |>
      where([chat_users], chat_users.chat_id == ^chat_id) |>
      where([chat_users], chat_users.user_id == ^user_id) |>
      preload([chat: :users])                             |>
      AwesomeApiV2.Repo.one
  end

  def find_user_chat_by!(chat_id, user_id) do
    AwesomeApiV2.Web.ChatUser                             |>
      where([chat_users], chat_users.chat_id == ^chat_id) |>
      where([chat_users], chat_users.user_id == ^user_id) |>
      preload([chat: :users])                             |>
      AwesomeApiV2.Repo.one!
  end
end
