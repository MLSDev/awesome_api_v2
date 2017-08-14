defmodule AwesomeApiV2.Web.UserView do
  use AwesomeApiV2.Web, :view

  def render(
    "index.json", %{
      collection:    collection,
      page_number:   page_number,
      page_size:     _page_size,
      total_pages:   total_pages,
      total_entries: _total_entries
      }
    ) do
    %{
      collection:   render_many(collection, AwesomeApiV2.Web.UserView, "user.json"),
      total_pages:  total_pages,
      current_page: page_number
    }
  end

  def render("show.json", %{ user: user }), do: render_one(user, AwesomeApiV2.Web.UserView, "user.json")

  def render("user.json", %{ user: user }) do
    %{
      id:         user.id,
      email:      user.email,
      first_name: user.first_name,
      last_name:  user.last_name,
      username:   user.username,
      avatar:     render_user_avatar(user),
      created_at: Ecto.DateTime.to_iso8601(user.created_at)
    }
  end

  def render("profile.json", %{ user: user }) do
    %{
      id:                   user.id,
      email:                user.email,
      first_name:           user.first_name,
      last_name:            user.last_name,
      username:             user.username,
      avatar:               render_user_avatar(user),
      unreaded_chats_count: 0,
      created_at:           Ecto.DateTime.to_iso8601(user.created_at)
    }
  end

  def render("profile_with_session.json", %{ user: user }) do
    %{
      user:    render("profile.json", %{ user: user }),
      session: %{
        value: List.first(user.auth_tokens).value
      }
    }
  end

  defp render_user_avatar(user) do
    case user.avatar_file_name do
      nil     -> nil
      ""      -> nil
      _       -> %{
        original: AwesomeApiV2.Web.User.Avatar.url({ user.avatar_file_name, user }, :original),
        medium:   AwesomeApiV2.Web.User.Avatar.url({ user.avatar_file_name, user }, :medium),
        thumb:    AwesomeApiV2.Web.User.Avatar.url({ user.avatar_file_name, user }, :thumb)
      }
    end
  end
end
