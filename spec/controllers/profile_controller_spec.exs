# https://github.com/kerryb/todo-phoenix/blob/4c7deee06cac2fac44556a9952fe60cdf95b9f5e/spec/controllers/item_controller_spec.exs

# https://github.com/maorleger/tracker2x2/blob/2dcf4682692dacf203e5971c9ac453ca90845b46/spec/controllers/auth_controller_spec.exs

# https://github.com/phoenixframework/phoenix/blob/master/lib/phoenix/test/conn_test.ex

defmodule AwesomeApiV2.ProfileControllerSpec do
  use ESpec.Phoenix, controller: AwesomeApiV2.Web.ProfileController
import Logger
  let :current_user do
    %AwesomeApiV2.Web.User{
      id:       34,
      email:      Faker.Internet.email,
      first_name: Faker.Name.first_name,
      last_name:  Faker.Name.last_name,
      created_at: Ecto.DateTime.utc
    }
  end

  describe "show.json" do
    context "user is authorized" do
      let :conn do
        build_conn()
          |> assign(:current_user, current_user())
          |> put_req_header("accept", "application/json")
      end

      let :response do
        conn()
          |> get( profile_path conn(), :show )
      end

      before do
        allow AwesomeApiV2.Web.AuthenticateUser |> to(accept :call, fn(conn, _) -> conn end)
      end

      # before do
        # allow AwesomeApiV2.Web.ProfileView |> to(accept(:render, fn("show.json", _) -> :rendering_is_here end))
      # end

      it "status should be ok", do: expect(response().status).to eq 200

      it "lets check the response" do
        profile = json_response(response(), 200)

        expect profile["id"]         |> to(eq current_user().id)
        expect profile["email"]      |> to(eq current_user().email)
        expect profile["first_name"] |> to(eq current_user().first_name)
        expect profile["last_name"]  |> to(eq current_user().last_name)
      end
    end

    context "without authorization" do
      let :conn do
        build_conn()
          |> put_req_header("accept", "application/json")
      end

      let :response do
        conn()
          |> get( profile_path conn(), :show )
      end

      it "status should be not authorized", do: expect(response().status).to eq 401
    end
  end

  describe "create.json [sucess]" do
    let :conn do
      build_conn()
        |> put_req_header("accept", "application/json")
    end

    let :password do
      SecureRandom.urlsafe_base64(3)
    end

    let :params do
      %{
        first_name:            Faker.Name.first_name,
        last_name:             Faker.Name.last_name,
        email:                 Faker.Internet.email,
        password:              password(),
        password_confirmation: password()
      }
    end

    let :response do
      conn()
        |> post( profile_path(conn(), :create), [
          user: params()
        ]
      )
    end

    it "status should be ok", do: expect(response().status).to eq 201

    it "lets check the response" do
      profile = json_response(response(), 201)

      expect profile["user"]["id"]         |> to_not(be_nil())
      expect profile["user"]["email"]      |> to(eq params().email)
      expect profile["user"]["first_name"] |> to(eq params().first_name)
      expect profile["user"]["last_name"]  |> to(eq params().last_name)
      expect profile["user"]["created_at"] |> to_not(be_nil())
      expect profile["user"]["password"]   |> to(be_nil())
    end
  end

  describe "create.json [errors]" do
    let :conn do
      build_conn()
        |> put_req_header("accept", "application/json")
    end

    let :params do
      %{
        first_name:            Faker.Name.first_name,
        last_name:             Faker.Name.last_name,
        email:                 nil,
        password:              SecureRandom.urlsafe_base64(3),
        password_confirmation: SecureRandom.urlsafe_base64(3)
      }
    end

    let :response do
      conn()
        |> post( profile_path(conn(), :create), [
          user: params()
        ]
      )
    end

    it "status should be ok", do: expect(response().status).to eq 422

    let :errors, do: json_response response(), 422

    it "lets check the response" do
      expect errors()["errors"]["email"]                 |> to_not(be_nil())
      expect errors()["errors"]["password_confirmation"] |> to_not(be_nil())
    end
  end
end
