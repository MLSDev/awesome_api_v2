defmodule AwesomeApiV2.Web.ProfileController do
  use AwesomeApiV2.Web, :controller

  plug AwesomeApiV2.Web.AuthenticateUser when action in [:show, :update]

  plug :scrub_params, "user"             when action in [:create, :update]

  action_fallback AwesomeApiV2.Web.FallbackController

  def show(conn, _opt) do
    render(conn, AwesomeApiV2.Web.UserView, "profile.json", user: conn.assigns.current_user)
  end

  def create(conn, %{ "user" => profile_params }) do
    case AwesomeApiV2.Web.Profile.create(conn, profile_params) do
      #
      # actualy is  -->   %{send_welcome_email: send_welcome_email, user: user}
      #
      { :ok, %{ user: user } } ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", profile_path(conn, :show))
        |> render(AwesomeApiV2.Web.UserView, "profile_with_session.json", user: user)
      {:error, :user, changeset, %{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
      {:error, :send_welcome_email, changeset, %{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: %{ welcome_email: ["sending failed"] } })
      { :error, changeset } ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"user" => user_params}) do
    user = conn.assigns.current_user

    case AwesomeApiV2.Web.Profile.update(conn, user, user_params) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, _opt) do
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(conn.assigns.current_user)

    send_resp(conn, :no_content, "")
  end
end
