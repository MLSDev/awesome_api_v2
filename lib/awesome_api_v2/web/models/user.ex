defmodule AwesomeApiV2.Web.User do
  use AwesomeApiV2.Web, :model
  use Arc.Ecto.Schema

  schema "users" do
    has_many :messages,           AwesomeApiV2.Web.Message, foreign_key: :author_id
    has_many :chat_users,         AwesomeApiV2.Web.ChatUser
    has_many :chats,              through: [:chat_users, :chat]

    has_many :auth_tokens,        AwesomeApiV2.Web.AuthToken

    field :username,              :string
    field :email,                 :string
    field :first_name,            :string
    field :last_name,             :string
    field :password_digest,       :string
    field :password,              :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :online,                :boolean, default: false
    #
    # avatar
    #
    field :avatar_file_name,      :string
    field :avatar_content_type,   :string
    field :avatar_file_size,      :integer
    field :avatar_updated_at,     Ecto.DateTime

    # https://github.com/elixir-ecto/ecto/blob/v2.1.6/lib/ecto/schema.ex#L470
    timestamps([
      {:inserted_at, :created_at},
      {:updated_at,  :updated_at},
      {:type,        Ecto.DateTime}
    ])
  end
end

# import Ecto.Query

# convert Ecto.DateTime to unix timestamp
# r.created_at |> Ecto.DateTime.to_erl |> :calendar.datetime_to_gregorian_seconds |> Kernel.-(62167219200)

# r = AwesomeApiV2.Web.User |> where([users], users.id == ^1) |> preload([:chats]) |> AwesomeApiV2.Repo.one

# r = AwesomeApiV2.Web.User |> where([users], users.id == ^1) |> AwesomeApiV2.Repo.one

# r = AwesomeApiV2.Web.User |> where([users], users.id == ^1) |> AwesomeApiV2.Repo.one

# r = AwesomeApiV2.Web.User |> limit(1) |> AwesomeApiV2.Repo.one
