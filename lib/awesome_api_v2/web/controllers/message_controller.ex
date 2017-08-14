defmodule AwesomeApiV2.Web.MessageController do
  use AwesomeApiV2.Web, :controller

  plug AwesomeApiV2.Web.AuthenticateUser

  plug AwesomeApiV2.Web.Policies.MessagesPolicy when action in [:index]

  action_fallback AwesomeApiV2.Web.FallbackController

  def index(conn, params) do
    render(conn, "index.json", messages: collection(conn, params, conn.assigns.current_user.id))
  end

  def create(conn, params) do
    case AwesomeApiV2.Web.MessageFactory.create(
      conn,
      conn.assigns.current_user,
      conn.assigns.current_chat_user.chat,
      params["message"]
    ) do
      { :ok, %{message: message} } ->
        conn
        |> put_status(:created)
        # |> put_resp_header("location", message_path(conn, :show)) # isnt needed for api actually
        |> render("show.json", message: message)
      {:error, :message, changeset, %{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
      {:error, :send_message_to_socket, changeset, %{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: %{ send_message_to_socket: ["sending failed"] } })
      { :error, changeset } ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  # def update(conn, %{"id" => id, "message" => message_params}) do
  #   current_user = conn.assigns.current_user

  #   message = AwesomeApiV2.Web.Finders.MessageFinder.find_by_id_and_user_id id, current_user.id

  #   with {:ok, %Message{} = message} <- Messages.update_message(message, message_params) do
  #     render(conn, "show.json", message: message)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   message = Messages.get_message!(id)
  #   with {:ok, %Message{}} <- Messages.delete_message(message) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end

  #
  # PRIVATE
  #
  defp collection(conn, params, current_user_id) do
    AwesomeApiV2.Web.MessagesSearcher.search_by conn, params, current_user_id
  end
end
