defmodule AwesomeApiV2.Web.SessionView do
  use AwesomeApiV2.Web, :view

  def render("show.json", %{session: session}) do
    render_one session, AwesomeApiV2.Web.SessionView, "session.json"
  end

  def render("session.json", %{session: session}) do
    %{
      token: session.value
    }
  end

  def render("error.json", _assigns) do
    %{
      errors: "Invalid credentials"
    }
  end
end
