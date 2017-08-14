defmodule AwesomeApiV2.Web.EnumsHelper do
  @moduledoc "Thx for http://tech.honestbee.com/articles/elixir/2017-04/enums-in-elixir-ecto"

  defmacro enum(name, [do: block]) do
    enum_values = case block do
      {_, _, values} when is_list(values) ->
        values
      _ ->
        quote do
          {:error, "please provide Map with %{key: value} for enum"}
        end
    end

    quote do
      import Inflex

      def unquote(:"#{ Inflex.pluralize(name) }")() do
        unquote(enum_values)
      end
    end
  end
end
