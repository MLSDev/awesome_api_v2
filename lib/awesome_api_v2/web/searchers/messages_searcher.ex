defmodule AwesomeApiV2.Web.MessagesSearcher do
  import Ecto.Query

  def search_by(_conn, params, user_id) do
    collection = AwesomeApiV2.Web.Message

    collection = collection |> where([messages], messages.chat_id == ^params["chat_id"])

    collection = collection |> order_by(desc: :id)

    collection = collection |> preload([:author])

    collection = collection |> AwesomeApiV2.Repo.paginate(page_size: params["per"], page: params["page"])

    collection
  end
end
