# https://github.com/stavro/arc
# https://gist.github.com/rsgrafx/21746ddf4c3dc6a2ebf2a17de5055408 -> Setting up Arc in a phoenix app that was ported from a
#   rails app using paperclip.
#
defmodule AwesomeApiV2.Web.User.Avatar do
  use Arc.Definition
  import Logger

  # Override the persisted filenames:
  # @acl :public_read_write

  def acl(:original, _), do: :public_read
  def acl(:medium, _),   do: :public_read
  def acl(:thumb,    _), do: :public_read

  # To add a thumbnail version:
  @versions [:original, :medium, :thumb]

  @extension_whitelist ~w(.jpg .jpeg .png, .JPG, .JPEG, .PNG)

  # Whitelist file extensions:
  def validate({ file, _ }), do: @extension_whitelist |> Enum.member?(Path.extname(file.file_name))

  # Define a thumbnail transformation:
  def transform(:thumb,  _), do: {:convert, "-thumbnail 100x100^ -gravity center -extent 100x100", :png}
  def transform(:medium, _), do: {:convert, "-background none -strip -thumbnail 100x100",          :png}

  def default_url(:thumb),   do: "https://placehold.it/100x100"
  def default_url(:medium),  do: "https://placehold.it/300x300"
  def default_url(:original),do: "https://placehold.it/1000x1000"

  def __storage do
    case Mix.env do
      :dev  -> Arc.Storage.Local
      :prod -> Arc.Storage.S3
      :test -> Arc.Storage.Local
    end
  end

  # must match ‘/:class/:attachment/:id_partition/:style/:filename’ from paperclip config
  # https://d1zr4x9rt15c9g.cloudfront.net/users/avatars/000/000/031/original/1498294039.jpeg?1498294039
  #
  def storage_dir(style, { file, legacy }) do
    case legacy do
      %AwesomeApiV2.Web.User{} -> paperclip_url(style, legacy)
      # _                        -> _avatar_url_hash(style, legacy)
    end
  end

  # defp _avatar_url_hash(style, legacy) do
  #   ecto_date = case Mix.env do
  #     :dev   -> legacy.created_at
  #     :prod  -> legacy.created_at
  #     :test  -> legacy.inserted_at
  #   end

  #   timestamp = AwesomeApiV2.Web.User.to_timestamp(ecto_date)

  #   hash = "users/avatars/#{ legacy.id }/#{ style }/#{ timestamp }"
  #     # |> _encode
  #     |> String.downcase

  #   "users/#{ hash }/#{ legacy.id }/#{ style }"
  # end

  def paperclip_url(style, legacy) do
    coded = _storage_dir(style, legacy)
            # |> _encode
            |> String.downcase

    "#{ coded }"
  end

  defp _storage_dir(hash, legacy), do: "users/avatars/#{ id_partition_part(legacy) }/#{ hash }"

  # def filename(_version, _arc_file), do: :os.system_time(:seconds)

  def id_partition_part(legacy) do
   String.pad_leading("#{ legacy.id }", 9, "0")
    |> String.split(~r/\d{3}/, include_captures: true, trim: true)
    |> Enum.join("/")
 end

  # def paperclip_timestamp(%AwesomeApiV2.Web.User{}=legacy) do
  #   legacy.avatar_updated_at
  #     |> AwesomeApiV2.Web.User.to_timestamp
  # end

  # def paperclip_timestamp(not_legacy), do: :os.system_time(:seconds)

  # def _encode(url) do
  #   :crypto.hmac(:sha, System.get_env("PAPERCLIP_HASH_SECRET"), url)
  #     |> Base.encode16
  # end
end

# import Ecto.Query
# current_user = AwesomeApiV2.Web.User |> limit(1) |> AwesomeApiV2.Repo.one
# AwesomeApiV2.Web.User.Avatar.url({ "avatar.png", current_user}, :medium)
