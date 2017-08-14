defmodule AwesomeApiV2.Web.Builders.Changesets.UpdateUserChangesetBuilder do
  use AwesomeApiV2.Web.UserHelpers, :changeset

  def build(user, params \\ :empty) do
    user
      |> Ecto.Changeset.cast(params, permitted_params())
      |> generate_searchable_fullname # AwesomeApiV2.Web.UserHelpers
      |> Ecto.Changeset.validate_length(:email, min: 1, max: 255)
      |> Ecto.Changeset.validate_format(:email, ~r/@/)
      |> Ecto.Changeset.validate_length(:password, min: 6)
      |> Ecto.Changeset.validate_confirmation(:password, message: "does not match")
      |> Ecto.Changeset.unique_constraint(:email)
      |> put_password_hash # AwesomeApiV2.Web.UserHelpers
  end

  defp permitted_params do
    [:email, :first_name, :last_name, :password, :password_confirmation, :username]
  end
end
