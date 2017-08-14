defmodule AwesomeApiV2.Web.MessageView do
  use AwesomeApiV2.Web, :view
  alias AwesomeApiV2.Web.MessageView
  alias AwesomeApiV2.Web.UserView

  def render("index.json", %{messages: messages}) do
    render_many messages, MessageView, "message.json"
  end

  def render("show.json", %{message: message}) do
    render_one message, MessageView, "message.json"
  end

  def render("message.json", %{message: message}) do
    %{
      id:     message.id,
      text:   message.text,
      author: render_one(message.author, UserView, "user.json")
    }
  end
end
