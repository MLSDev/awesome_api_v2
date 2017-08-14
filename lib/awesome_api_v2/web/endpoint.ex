defmodule AwesomeApiV2.Web.Endpoint do
  use Phoenix.Endpoint, otp_app: :awesome_api_v2

  socket "/phoenix/socket", AwesomeApiV2.Web.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :awesome_api_v2, gzip: false,
    #
    # image uploads?!
    #
    # at: "/uploads", from: Path.expand('./uploads'), gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading?, do: plug Phoenix.CodeReloader

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [
      :urlencoded,
      :multipart,
      :json
    ],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store:        :cookie,
    key:          "_awesome_api_v2_key",
    signing_salt: "QXRYlBHq"

  plug CORSPlug

  plug AwesomeApiV2.Web.Router
end
