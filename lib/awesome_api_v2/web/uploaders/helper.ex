#
# http://radzserg.com/2016/10/10/elixir-phoenix-models-with-images-part2/
#
defmodule AwesomeApiV2.Web.Uploaders.Helper do
  def get_mime!(path) do
   { result, 0 } = System.cmd "file", ["--mime-type"|[path]]

   result
    |> String.split(":")
    |> List.last
    |> String.trim
    |> String.downcase
  end

  def get_size!(path) do
   stat = File.stat! path

   stat.size
  end
end
