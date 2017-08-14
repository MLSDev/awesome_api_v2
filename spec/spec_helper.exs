Code.require_file("#{__DIR__}/phoenix_helper.exs")

ESpec.configure fn(config) ->
  config.before fn(tags) ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(AwesomeApiV2.Repo)

    # {:ok, _} = Application.ensure_all_started(:ex_machina)

    {:shared, hello: :world, tags: tags}
  end

  config.finally fn(_shared) ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkin(AwesomeApiV2.Repo, [])

    :ok
  end
end
