defmodule AwesomeApiV2.Web.Finders.MessageFinder do
  import Ecto.Query

  def find_by_id_and_user_id(id, user_id) do
    AwesomeApiV2.Web.Message                             |>
      where([messages], messages.id == ^id)              |>
      where([messages], messages.author_id == ^user_id)  |>
      AwesomeApiV2.Repo.one
  end

  def find_by_id_and_user_id!(id, user_id) do
    AwesomeApiV2.Web.Message                             |>
      where([messages], messages.id == ^id)              |>
      where([messages], messages.author_id == ^user_id)  |>
      AwesomeApiV2.Repo.one!
  end
end
