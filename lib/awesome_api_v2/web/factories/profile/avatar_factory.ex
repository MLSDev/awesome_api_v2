defmodule AwesomeApiV2.Web.Profile.AvatarFactory do
  import Logger

  def create(_conn, current_user, avatar_params \\ %{}) do
    avatar_params = Map.put(avatar_params, :filename, "#{ :os.system_time(:seconds) }#{ Path.extname(avatar_params.filename) }")

    user_changeset = _user_changeset(current_user, avatar_params)

    Logger.info '--->'
    Logger.info inspect user_changeset

    multi =
      Ecto.Multi.new                                             |>
      Ecto.Multi.update(:profile, user_changeset)                |>
      Ecto.Multi.run(:file, &generate_avatar(&1, avatar_params))

    AwesomeApiV2.Repo.transaction multi
  end

  defp generate_avatar(%{ profile: profile }, avatar_params) do
    AwesomeApiV2.Web.User.Avatar.store({ avatar_params, profile })
  end

  defp _user_changeset(current_user, avatar_params) do
    Ecto.Changeset.cast(current_user, user_params_via(avatar_params), permitted_params())
  end

  defp user_params_via(avatar_params) do
    %{
      avatar_file_name:    avatar_params.filename,
      avatar_file_size:    AwesomeApiV2.Web.Uploaders.Helper.get_size!(avatar_params.path),
      avatar_content_type: AwesomeApiV2.Web.Uploaders.Helper.get_mime!(avatar_params.path),
      avatar_updated_at:   Ecto.DateTime.utc
    }
  end

  defp permitted_params() do
    [:avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at]
  end
end
