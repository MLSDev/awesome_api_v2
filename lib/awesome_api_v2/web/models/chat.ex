defmodule AwesomeApiV2.Web.Chat do
  use AwesomeApiV2.Web, :model
  use Arc.Ecto.Schema

  schema "chats" do
    has_many :messages,     AwesomeApiV2.Web.Message

    has_many :message_users, AwesomeApiV2.Web.MessageUser

    has_many :chat_users,   AwesomeApiV2.Web.ChatUser
    has_many :users,        through: [:chat_users, :user]

    field :last_message_at, Ecto.DateTime
    field :name,            :string
    # field :private,         :boolean, default: false

    timestamps([
      {:inserted_at, :created_at},
      {:updated_at,  :updated_at},
      {:type,        Ecto.DateTime}
    ])
  end
end


# m = AwesomeApiV2.Web.Chat |> where([chats], chats.id == ^2) |> preload([chat_users: :users]) |> AwesomeApiV2.Repo.one

# AwesomeApiV2.Web.ChatUser |> where([chat_users], chat_users.chat_id == ^1) |> where([chat_users], chat_users.user_id == ^1) |> AwesomeApiV2.Repo.one

# u = AwesomeApiV2.Web.User |> where([users], users.id == ^1) |> AwesomeApiV2.Repo.one!
