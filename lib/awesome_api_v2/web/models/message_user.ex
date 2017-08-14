defmodule AwesomeApiV2.Web.MessageUser do
  use AwesomeApiV2.Web, :model
  use Arc.Ecto.Schema

  schema "message_users" do
    belongs_to :message,        AwesomeApiV2.Web.Message
    belongs_to :user,           AwesomeApiV2.Web.User

    field :deleted,             :boolean, default: false
    field :status,              :integer, default: 0

    timestamps([
      {:inserted_at, :created_at},
      {:updated_at,  :updated_at},
      {:type,        Ecto.DateTime}
    ])
  end
end


