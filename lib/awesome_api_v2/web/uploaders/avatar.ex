# #
# #
# # https://github.com/stavro/arc
# # https://gist.github.com/rsgrafx/21746ddf4c3dc6a2ebf2a17de5055408 -> Setting up Arc in a phoenix app that was ported from a rails
# #   app using paperclip.
# #
# defmodule AwesomeApiV2.Web.Avatar do
#   use Arc.Definition
#   use Arc.Ecto.Definition # Include ecto support (requires package arc_ecto installed):

#   import Inflex
#   import Logger

#   # Override the persisted filenames:
#   # @acl :public_read_write

#   def acl(:original, _), do: :public_read
#   def acl(:thumb, _),    do: :public_read

#   # To add a thumbnail version:
#   @versions [:original, :thumb]

#   # Whitelist file extensions:
#   def validate({ file, _ }) do
#     ~w(.jpg .jpeg .png) |> Enum.member?(Path.extname(file.file_name))
#   end

#   # Define a thumbnail transformation:
#   def transform(:thumb, _) do
#     {:convert, "-background none -strip -thumbnail 50x50", :png}
#   end

#   #
#   #
#   #
#   # def __storage, do: Arc.Storage.S3

#   # def __storage, do: Arc.Storage.Local # Add this

#   # must match ‘/:class/:attachment/:id_partition/:style/:filename’ from paperclip config

#   # https://d1zr4x9rt15c9g.cloudfront.net/users/avatars/000/000/031/original/1498294039.jpeg?1498294039

#   def storage_dir(style, {file, legacy}) do
#     case legacy do
#       %AwesomeApiV2.Web.User{} -> paperclip_url(style, legacy)
#       _                        -> _avatar_url_hash(style, legacy)
#     end
#   end

#   defp _avatar_url_hash(style, legacy) do
#     ecto_date = case Mix.env do
#       :dev   -> legacy.created_at
#       :prod  -> legacy.created_at
#       :test  -> legacy.inserted_at
#     end

#     timestamp = AwesomeApiV2.Web.User.to_timestamp(ecto_date)

#     hash = "users/avatars/#{ legacy.id }/#{ style }/#{ timestamp }"
#       # |> _encode
#       |> String.downcase

#     Logger.debug "_avatar_url_hash"
#     Logger.debug "users/#{ hash }/#{ legacy.id }/#{ style }"

#     "users/#{ hash }/#{ legacy.id }/#{ style }"
#   end

#   def paperclip_url(style, legacy) do
#     coded = _storage_dir(style, legacy)
#             # |> _encode
#             |> String.downcase

#     # Logger.debug "paperclip_url"
#     Logger.debug "coded => #{ coded }"
#     # Logger.debug "users/#{ coded }/#{ legacy.id }/#{ style }/"

#     # "#{ coded }/#{ legacy.id }/#{ style }/"

#     "#{ coded }"
#   end

#   defp _storage_dir(hash, legacy) do
#     Logger.debug "users/avatars/#{ id_partition_part(legacy) }/#{ hash }"

#     "users/avatars/#{ id_partition_part(legacy) }/#{ hash }"
#   end

#   def filename(_version, _arc_file) do
#     :os.system_time(:seconds)
#   end

#   def id_partition_part(legacy) do
#    String.pad_leading("#{ legacy.id }", 9, "0")
#     |> String.split(~r/\d{3}/, include_captures: true, trim: true)
#     |> Enum.join("/")
#  end

#   # def paperclip_timestamp(%AwesomeApiV2.Web.User{}=legacy) do
#   #   legacy.avatar_updated_at
#   #     |> AwesomeApiV2.Web.User.to_timestamp
#   # end

#   # def paperclip_timestamp(not_legacy), do: :os.system_time(:seconds)

#   # def _encode(url) do
#   #   :crypto.hmac(:sha, System.get_env("PAPERCLIP_HASH_SECRET"), url)
#   #     |> Base.encode16
#   # end

#   # def default_url(:thumb) do
#   #   "https://placehold.it/100x100"
#   # end
# end
