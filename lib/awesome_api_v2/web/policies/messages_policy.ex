defmodule AwesomeApiV2.Web.Policies.MessagesPolicy do
  import Plug.Conn
  import Ecto.Query

  use Phoenix.Controller, namespace: AwesomeApiV2.Web

  alias AwesomeApiV2.Web.{ ChatUser }

  alias AwesomeApiV2.{ Repo }

  import Logger

  @moduledoc """
    Comming soon...
  """

  def init(options), do: options

  def call(conn, _opts) do
    case find_chat_user(conn) do
      nil ->
        conn
        |> put_status(403)
        |> render(AwesomeApiV2.Web.ErrorView, "403.json", %{ message: "You are not able to get messages from this chat." })
        |> halt
      chat_user -> conn |> assign(:current_chat_user, chat_user)
    end
  end

  defp find_chat_user(conn) do
    AwesomeApiV2.Web.Finders.ChatUserFinder.find_user_chat_by conn.params["chat_id"], conn.assigns.current_user.id
  end
end
