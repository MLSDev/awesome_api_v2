defmodule AwesomeApiV2.Web.UserHelpers do
#
# changeset
#
def changeset do
quote do

  defp generate_searchable_fullname(changeset) do
    case changeset do
      %Ecto.Changeset{ valid?: true, changes: %{ first_name: first_name, last_name: last_name } } -> Ecto.Changeset.put_change(
        changeset, :username, "#{ first_name } #{ last_name } #{ first_name }"
      )
      _ -> changeset
    end
  end

  defp put_password_hash(changeset) do
    #
    # TODO: em?
    #
    case changeset do
      %Ecto.Changeset{ valid?: true, changes: %{ password: password } } -> Ecto.Changeset.put_change(
        changeset, :password_digest, Comeonin.Bcrypt.hashpwsalt(password)
      )
      _ -> changeset
    end
  end

end
end

#
#
#

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
