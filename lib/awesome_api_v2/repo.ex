defmodule AwesomeApiV2.Repo do
  use Ecto.Repo, otp_app: :awesome_api_v2

  use Scrivener, page_size: 10
end
