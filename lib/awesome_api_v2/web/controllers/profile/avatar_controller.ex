defmodule AwesomeApiV2.Web.Profile.AvatarController do
  use AwesomeApiV2.Web, :controller

  # plug AwesomeApiV2.Web.AuthenticateUser

  import Logger

  def create(conn, %{ "attachment" => avatar_params }) do
    IO.inspect avatar_params

    # current_user = conn.assigns.current_user

    current_user = AwesomeApiV2.Web.User |> limit(1) |> AwesomeApiV2.Repo.one

    Logger.info '---->'
    Logger.info inspect current_user
    Logger.info '---->'

    case AwesomeApiV2.Web.Profile.AvatarFactory.create(conn, current_user, avatar_params) do
      { :ok, %{ profile: profile } } ->
        Logger.info '-----> current_user'
    Logger.info inspect(current_user)

        conn
        |> send_resp(:no_content, "")
      {:error, :file, changeset, %{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: %{ attachment: ["processing is failed"] } })
      { :error, :profile, changeset, %{} } ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AwesomeApiV2.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
