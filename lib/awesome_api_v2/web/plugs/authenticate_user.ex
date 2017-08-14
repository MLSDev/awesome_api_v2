defmodule AwesomeApiV2.Web.AuthenticateUser do
  import Plug.Conn
  import Ecto.Query

  alias AwesomeApiV2.Web.{User, Session, AuthToken}

  alias AwesomeApiV2.{Repo}

  import Logger

  @shortdoc "Identify current_user"

  @moduledoc """
    AuthenticateUser is repsonsible to authenticate user using header token.
    Writes `current_user` and `current_session` to `conn`
  """

  def init(options), do: options

  def call(conn, _opts) do
    case find_user(conn) do
      {:ok, user, session} -> conn |> assign(:current_user, user) |> assign(:current_session, session)
      _otherwise           -> auth_error!(conn)
    end
  end

  defp find_user(conn) do
    with auth_header = get_req_header(conn, "authorization"),
      {:ok, token  } <- parse_token(auth_header),
      {:ok, session} <- find_session_by_token(token) do
        # return user
        find_user_by_session(session)
     end
  end

  #
  # Parse two different type of authorization value.
  # Authorization: Token token="blablabla"
  # Authorization: Bearer "blablabla"
  #
  defp parse_token(["Token token=" <> token]), do: { :ok, String.replace(token, "\"", "") }
  defp parse_token(["Bearer " <> token]),      do: { :ok, String.replace(token, "\"", "") }
  defp parse_token(_no_token_provided),        do: :error

  defp find_session_by_token(token) do
    case AuthToken |> where([auth_tokens], auth_tokens.value == ^token) |> Repo.one do
      nil     -> :error
      session -> {:ok, session}
    end
  end

  defp find_user_by_session(session) do
    case Repo.get(User, session.user_id) do
      nil  -> :error
      user -> {:ok, user, session}
    end
  end

  defp auth_error!(conn) do
    conn
      |> send_resp(401, "")
      |> halt
  end
end
