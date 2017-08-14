defmodule AwesomeApiV2.Web.UserSocket do
  use Phoenix.Socket

  require Logger

  import Ecto.Query, only: [from: 2]

  channel "room:*", AwesomeApiV2.Web.ChatChannel, via: [:websocket]

  transport :websocket, Phoenix.Transports.WebSocket, timeout: 45_000
  transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(params, socket) do
    Logger.info "started connect ----------"
    Logger.debug inspect params["token"]
    Logger.debug inspect socket
    Logger.info "ended connect ----------"

    case find_user(params) do
      {:ok, user} -> {:ok, assign(socket, :current_user, user)}
      _otherwise -> :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     AwesomeApiV2.Web.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil

  defp find_user(params) do
    with token = params["token"], { :ok, session } <- find_session_by_token(token) do
      find_user_by_session(session)
    end
  end

  defp find_session_by_token(token) do
    case AwesomeApiV2.Repo.one(from s in AwesomeApiV2.Web.Session, where: s.value == ^token) do
      nil -> :error
      session -> {:ok, session}
    end
  end

  defp find_user_by_session(session) do
    case AwesomeApiV2.Repo.get(AwesomeApiV2.Web.User, session.user_id) do
      nil -> :error
      user -> {:ok, user}
    end
  end
end
