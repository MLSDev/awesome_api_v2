defmodule AwesomeApiV2.ProfileControllerTest do
  use AwesomeApiV2.ConnCase

  setup %{ conn: conn } do
    {
      :ok,
      conn: put_req_header(conn, "accept", "application/json")
    }
  end

  @valid_attrs %{
    email:               "some@example.com",
    first_name:          "some content",
    last_name:           "some content",
    password:            "some@content.com",
    searchable_fullname: "some content"
  }

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, profile_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["id"]
    refute json_response(conn, 201)["password"]
    assert Repo.get_by(AwesomeApiV2.User, %{ email: "some@example.com" })
  end

  # test "shows chosen resource", %{ conn: conn } do
  #   user = Repo.insert! %User{}

  #   conn = get conn, user_path(conn, :show, user)

  #   assert json_response(conn, 200)["data"] == %{
  #     "id"         => user.id,
  #     "email"      => user.email,
  #     "first_name" => user.first_name,
  #     "last_name"  => user.last_name,
  #     "birthday"   => user.birthday
  #   }
  # end
end
