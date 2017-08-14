defmodule AwesomeApiV2.Web.Builders.Changesets.CreateUserChangesetBuilder do
  use AwesomeApiV2.Web.UserHelpers, :changeset

  def build(params \\ %{}) do
    %AwesomeApiV2.Web.User{}
      |> Ecto.Changeset.cast(params, permitted_params())
      |> generate_searchable_fullname
      |> Ecto.Changeset.validate_length(:email, min: 1, max: 255)
      |> Ecto.Changeset.validate_format(:email, ~r/@/)
      |> Ecto.Changeset.validate_length(:password, min: 6)
      |> Ecto.Changeset.validate_confirmation(:password, message: "does not match")
      |> Ecto.Changeset.validate_required([:email, :first_name, :password])
      |> Ecto.Changeset.unique_constraint(:email)
      |> put_password_hash
      |> generate_session_for_user
  end

  defp permitted_params do
    [:email, :first_name, :last_name, :password, :password_confirmation, :username]
  end

  #
  # RPIVATE METHODS
  #
  defp generate_session_for_user(changeset) do
    case changeset do
      %Ecto.Changeset{ valid?: true } ->
        Ecto.Changeset.put_assoc(
          changeset,
          :auth_tokens,
          [
            %AwesomeApiV2.Web.AuthToken{ value: SecureRandom.urlsafe_base64 }
          ]
        )
      _ -> changeset
    end
  end
end
