defmodule AwesomeApiV2.UserTest do
  use AwesomeApiV2.ModelCase

  alias AwesomeApiV2.User

  @valid_attrs %{birthday: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, email: "some content", first_name: "some content", last_name: "some content", password_digest: "some content", searchable_fullname: "some content"}
  @invalid_attrs %{}

  # test "changeset with valid attributes" do
  #   changeset = User.changeset(%User{}, @valid_attrs)
  #   assert changeset.valid?
  # end

  # test "changeset with invalid attributes" do
  #   changeset = User.changeset(%User{}, @invalid_attrs)
  #   refute changeset.valid?
  # end
end
