defmodule AwesomeApiV2.Web.ChatUser do
  use AwesomeApiV2.Web, :model
  use Arc.Ecto.Schema

  schema "chat_users" do
    belongs_to :chat, AwesomeApiV2.Web.Chat
    belongs_to :user, AwesomeApiV2.Web.User

    field :unreaded,                   :boolean, default: false
    field :can_read_prejoined_history, :boolean, default: true
    field :admin,                      :boolean, default: false

    field :status,                     :integer, default: 0

    timestamps([
      {:inserted_at, :created_at},
      {:updated_at,  :updated_at},
      {:type,        Ecto.DateTime}
    ])
  end
end
