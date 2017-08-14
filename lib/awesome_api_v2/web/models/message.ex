defmodule AwesomeApiV2.Web.Message do
  use AwesomeApiV2.Web, :model
  use Arc.Ecto.Schema

  import AwesomeApiV2.Web.EnumsHelper

  enum "kind" do
    %{
      text:   1,
      media:  2,
      system: 3
    }
  end

  enum "system_message_kind" do
    %{
      chat_updated:        1,
      user_left_chat:      2,
      user_banned:         3,
      user_joined_chat:    4,
      users_added_to_chat: 5
    }
  end

  schema "messages" do
    belongs_to :chat,           AwesomeApiV2.Web.User
    belongs_to :author,         AwesomeApiV2.Web.User

    has_many :message_users,    AwesomeApiV2.Web.MessageUser

    field :kind,                :integer, default: 0
    field :system_message_kind, :integer
    field :text,                :string

    timestamps([
      {:inserted_at, :created_at},
      {:updated_at,  :updated_at},
      {:type,        Ecto.DateTime}
    ])
  end
end

# import Ecto.Query

# r = AwesomeApiV2.Web.Message |> limit(1) |> AwesomeApiV2.Repo.one
