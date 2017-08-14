defmodule AwesomeApiV2.Web.ChatController do
  use AwesomeApiV2.Web, :controller

  def index(conn, _params) do
    render conn, "lobby.html"
  end
end
