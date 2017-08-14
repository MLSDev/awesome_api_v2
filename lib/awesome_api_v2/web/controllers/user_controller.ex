defmodule AwesomeApiV2.Web.UserController do
  use AwesomeApiV2.Web, :controller

  alias AwesomeApiV2.Web.User

  plug AwesomeApiV2.Web.AuthenticateUser

  # use AwesomeApiV2.Web.UsersSwagger # disabled because of it wasnt implemented yet

  def index(conn, params) do
    collection = AwesomeApiV2.Web.UserSearcher.search_by(conn, params)

    render(
      conn,
      "index.json",
      collection:    collection.entries,
      page_number:   collection.page_number,
      page_size:     collection.page_size,
      total_pages:   collection.total_pages,
      total_entries: collection.total_entries
    )
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    render(conn, "show.json", user: user)
  end
end
