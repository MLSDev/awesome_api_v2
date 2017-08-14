defmodule AwesomeApiV2.Web.UserSearcher do
  import Ecto.Query

  def search_by(_conn, params) do
    collection = AwesomeApiV2.Web.User

    collection =
      case params["user_name"] do
        nil -> collection
        ""  -> collection
        _   -> collection |> where([users], like(users.first_name, ^("%#{ params["user_name"] }%")))
      end

    collection = collection |> order_by(desc: :inserted_at)

    collection = collection |> AwesomeApiV2.Repo.paginate(page_size: params["per"], page: params["page"])

    collection
  end
end
