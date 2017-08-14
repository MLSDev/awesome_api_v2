defmodule AwesomeApiV2.Web.Profile do
  use AwesomeApiV2.Web.UserHelpers, :changeset

  @doc """
  Create user using profile params and perform all necessary stuff
  """
  def create(_conn, profile_params \\ :empty) do
    user_changeset = AwesomeApiV2.Web.Builders.Changesets.CreateUserChangesetBuilder.build(profile_params)

    multi =
      Ecto.Multi.new                                                |>
      Ecto.Multi.insert(:user, user_changeset)                      |>
      Ecto.Multi.run(:send_welcome_email, &send_welcome_email(&1))

    AwesomeApiV2.Repo.transaction multi
  end

  @doc """
  Update current user. Not sure that it should be factory at all, so, TODO - decide how to perform it in better way.
  """
  def update(conn, user, profile_params \\ :empty) do
    AwesomeApiV2.Web.Builders.Changesets.UpdateUserChangesetBuilder.build(user, profile_params) |> AwesomeApiV2.Repo.update
  end

  #
  # RPIVATE METHODS
  #

  def send_welcome_email(%{ user: user }) do
    # Exq.enqueue_in(Exq, "default", 15, "WelcomeJob", [user.email, "#{ user.first_name } #{ user.last_name }"])

    Exq.enqueue(Exq, "default", WelcomeJob, [user.email, "#{ user.first_name } #{ user.last_name }"])

    {:ok, "ok"}
  end
end
