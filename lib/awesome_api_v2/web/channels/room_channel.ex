defmodule AwesomeApiV2.Web.RoomChannel do
  use AwesomeApiV2.Web, :channel

  require Logger

  def join(topic, message, socket) do
    Process.flag(:trap_exit, true)
    Process.register(self, String.to_atom(topic))
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def join("rooms:lobby", message, socket) do
    Process.flag(:trap_exit, true)
    send(self(), {:after_join, message})
    {:ok, socket}
  end

  def join("rooms:" <> _something_else, _msg, _socket) do
    {:error, %{reason: "can't do this"}}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:entered", %{user: msg["user"]}

    push socket, "join", %{status: "connected"}

    {:noreply, socket}
  end

  def handle_in("boom", _message, _socket) do
    raise "boom"
  end

  #
  # added
  #
  def handle_info(:ping, socket) do
    push socket, "new:msg", %{user: "SYSTEM", body: "ping"}

    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug "> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    broadcast! socket, "new:msg", %{user: msg["user"], body: msg["body"]}

    {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
  end
end
