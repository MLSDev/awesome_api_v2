defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias AwesomeApiV2.Repo
    end
  end

  def controller do
    quote do
      alias AwesomeApiV2
      import AwesomeApiV2.Web.Router.Helpers

      @endpoint AwesomeApiV2.Web.Endpoint
    end
  end

  def request do
    quote do
      alias AwesomeApiV2.Repo
      import AwesomeApiV2.Web.Router.Helpers
    end
  end

  def view do
    quote do
      import AwesomeApiV2.Web.Router.Helpers
    end
  end

  def channel do
    quote do
      alias AwesomeApiV2.Repo

      @endpoint AwesomeApiV2.Web.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
