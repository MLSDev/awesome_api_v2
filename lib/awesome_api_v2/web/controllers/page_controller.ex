defmodule AwesomeApiV2.Web.PageController do
  use AwesomeApiV2.Web, :controller

  action_fallback AwesomeApiV2.Web.FallbackController

  def index(conn, _params) do
    # {:ok, _jid} = Exq.enqueue_in(Exq, "default", 15, "WelcomeJob", ["stepaniuk@mlsdev.com", "D.S."])

    AwesomeApiV2.Web.Endpoint.broadcast! "room:lobby", "new:msg", %{ user: "user", message: "some" }

    # AwesomeApiV2.Web.Endpoint.broadcast! "room:lobby", "update", %{ user: "user" }

    render conn, "index.html"
  end
end
