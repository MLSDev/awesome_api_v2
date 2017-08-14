defmodule AwesomeApiV2.Web.SessionController do
  use AwesomeApiV2.Web, :controller

  alias AwesomeApiV2.Web.{ User, AuthToken }

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  plug AwesomeApiV2.Web.AuthenticateUser when action in [:update, :delete]

  # plug :scrub_params, "session"          when action in [:update] # have to be used

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: user_params["email"])

    cond do
      user && checkpw(user_params["password"], user.password_digest) ->
        auth_token_params = %{ user_id: user.id }

        {:ok, session} = \
          AwesomeApiV2.Web.Builders.Changesets.AuthToken.CreateChangesetBuilder.build(auth_token_params) |> Repo.insert

        conn
          |> put_status(:created)
          |> render("show.json", session: session)
      user ->
        conn
          |> put_status(:unauthorized)
          |> render("error.json", user_params)
      true ->
        dummy_checkpw()
        conn
          |> put_status(:unauthorized)
          |> render("error.json", user_params)
    end
  end

  def update(conn, session_params) do
    case \
      AwesomeApiV2.Web.Builders.Changesets.UpdateSessionChangesetBuilder.build(conn.assigns.current_session, session_params)
        |> Repo.update \
    do
      {:ok, _session}      -> send_resp(conn, :ok, "")
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, _) do
    with {:ok, _session} <- Repo.delete(conn.assigns.current_session) do
      send_resp(conn, :no_content, "")
    end
  end
end
