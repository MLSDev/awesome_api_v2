defmodule AwesomeApiV2.Repo.Migrations.InitialMigration do
  use Ecto.Migration

  def change do
    #
    # AuthTokens   (aka Session)
    #
    create_if_not_exists table(:auth_tokens) do
      add :value,       :string
      add :push_token,  :string
      add :device_type, :string
      add :user_id,     :serial
      add :online,      :boolean, default: false

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    create index :auth_tokens, [:user_id]

    #
    # chat_admin_changes
    #
    create_if_not_exists table(:chat_admin_changes) do
      add :chat_id,            :serial
      add :prev_admin_user_id, :serial
      add :next_admin_user_id, :serial

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    #
    # chat_users
    #
    create_if_not_exists table(:chat_users) do
      add :chat_id,                    :serial
      add :unreaded,                   :boolean, default: true
      add :can_read_prejoined_history, :boolean, default: true
      add :admin,                      :boolean, default: false
      add :status,                     :integer, default: 0

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    #
    # users
    #
    create_if_not_exists table(:users) do
      add :first_name,          :string
      add :last_name,           :string
      add :username,            :string
      add :password_digest,     :string
      add :email,               :string
      add :facebook_id,         :string
      add :online,              :boolean, default: true
      add :avatar_file_name,    :string
      add :avatar_content_type, :string
      add :avatar_file_size,    :string
      add :avatar_updated_at,   :string

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    create unique_index :users, [:email]

    #
    # chats
    #
    create_if_not_exists table(:chats) do
      add :last_message_at,     :naive_datetime
      add :name,                :string
      add :is_private,          :boolean, default: true
      add :avatar_file_name,    :string
      add :avatar_content_type, :string
      add :avatar_file_size,    :string
      add :avatar_updated_at,   :string

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    #
    # message_targets
    #
    create_if_not_exists table(:message_targets) do
      add :message_id,      :serial
      add :user_id,         :serial

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    create index :message_targets, [:message_id]
    create index :message_targets, [:user_id]

    #
    # message_users
    #
    create_if_not_exists table(:message_users) do
      add :message_id,      :serial
      add :user_id,         :serial
      add :deleted,         :boolean, default: false
      add :status,          :integer, default: 0

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    #
    # messages
    #
    create_if_not_exists table(:messages) do
      add :kind,                :integer, default: 0
      add :system_message_kind, :integer
      add :chat_id,             :serial
      add :author_id,           :serial
      add :text,                :text

      add :file_file_name,    :string
      add :file_content_type, :string
      add :file_file_size,    :string
      add :file_updated_at,   :string

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    create index :messages, [:author_id]
    create index :messages, [:chat_id]

    #
    # recoveries
    #
    create_if_not_exists table(:recoveries) do
      add :code,       :string
      add :user_id,    :serial
      add :expires_at, :naive_datetime

      timestamps([
        {:inserted_at, :created_at},
        {:updated_at,  :updated_at}
      ])
    end

    create index :recoveries, [:user_id]
    create index :recoveries, [:code]
  end
end
