defmodule AwesomeApiV2.Web.Router do
  use AwesomeApiV2.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/phoenix", AwesomeApiV2.Web do
    pipe_through :browser # Use the default browser stack

    # get "/", ChatController, :index

    get "/page", PageController, :index
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/phoenix/api", AwesomeApiV2.Web do
    pipe_through :api

    resources "/users",    UserController,    only: [:index, :show]

    scope "/profile" do
      resources "/avatar",  Profile.AvatarController, only: [:create, :update, :delete],  singleton: true
    end

    resources "/profile",  ProfileController, only: [:create, :update, :show],            singleton: true

    resources "/session",  SessionController, only: [:create, :update, :delete],          singleton: true

    resources "/chats", ChatController do
      resources "/messages", MessageController, only: [:index, :create]
    end
  end

  scope "/phoenix/api/swagger" do
    pipe_through :api

    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :awesome_api_v2, swagger_file: "swagger.json"
  end

  def swagger_info, do: %{ info: %{ version: "1.0", title: "AwesomeApiV2 App" } }

  # pipeline :exq do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :put_secure_browser_headers
  #   plug ExqUi.RouterPlug, namespace: "exq"
  # end

  # scope "/exq", ExqUi do
  #   pipe_through :exq
  #   forward "/", RouterPlug.Router, :index
  # end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end
end
