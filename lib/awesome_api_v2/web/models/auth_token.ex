defmodule AwesomeApiV2.Web.AuthToken do
  use AwesomeApiV2.Web, :model

  schema "auth_tokens" do
    belongs_to :user,       AwesomeApiV2.Web.User

    field      :value,       :string
    field      :push_token,  :string
    field      :device_type, :string
    field      :online,      :boolean, default: false

    timestamps([
      {:inserted_at, :created_at},
      {:updated_at,  :updated_at},
      {:type,        Ecto.DateTime}
    ])
  end
end

# r = AwesomeApiV2.Web.AuthToken |> where([auth_tokens], auth_tokens.id == ^2) |> AwesomeApiV2.Repo.one

# r = AwesomeApiV2.Web.AuthToken |> limit(1) |> AwesomeApiV2.Repo.one
