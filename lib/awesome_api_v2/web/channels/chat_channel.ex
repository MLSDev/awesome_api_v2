defmodule AwesomeApiV2.Web.ChatChannel do
  use Phoenix.Channel

  require Logger

  def join("room:lobby", msg, socket) do
  # def join("room:" <> room_id, msg, socket) do
    Logger.info "join started --------"
    Logger.debug "msg => #{ inspect msg }"

    # When this process receives an exit signal other than :kill signal,
    # it will be converted into a message that will be received inside the receive block.
    # In Erlang/Elixir, this is what makes supervisor trees possible.
    # Process.flag :trap_exit, true

    #
    # Why do we need this?
    #
    # Process.register self(), String.to_atom("room:#{ room_id }")

    #
    # handle_info :ping, socket
    #
    # DO WE NEED TO PING CLIENT EACH 5 sec?
    #
    # :timer.send_interval 5000, :ping

    #
    # send into socket  `handle_in`
    #
    send(self(), :after_join)

    Logger.info "join ended --------"

    if true do
      { :ok, %{ message: "Joined" }, socket }
    else
      # { :error, %{reason: "can't do this"} }
      { :error, :authentication_required }
    end
  end

  def handle_info(:ping, socket) do
    Logger.info "handle_info PING started -----"

    push socket, "new:msg", %{ user: "SYSTEM", body: "ping" }

    Logger.info "handle_info PING ended -----"

    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    Logger.info "handle_info AFTER JOIN started -----"

    broadcast! socket, "user:entered", %{ user: "SYSTEM" }

    Logger.debug inspect socket

    push socket, "join", %{ status: "connected" }

    # https://medium.com/@Stephanbv/elixir-phoenix-build-a-simple-chat-room-7f20ee8e8f9c
    # http://work.stevegrossi.com/2016/07/11/building-a-chat-app-with-elixir-and-phoenix-presence/
    # AwesomeApiV2.Web.Presence.track(socket, socket.assigns.current_user, %{ online_at: :os.system_time(:milli_seconds) })
    # push socket, "presence_state", AwesomeApiV2.Web.Presence.list(socket)

    Logger.info "handle_info AFTER JOIN ended -----"

    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload

    Logger.info "handle_out ************************ #{ inspect event } #{ inspect payload } #{ inspect socket }"

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    Logger.info("client ping ----------")

    {:reply, {:ok, payload}, socket}
  end

  #
  # is not used atually
  #
  def handle_in(event = "new:msg", payload, socket) do
    broadcast! socket, event, payload

    Logger.info("payload: #{ inspect payload }")

    # {:reply, {:ok, %{msg: payload["body"]}}, socket}

    # {:noreply, socket}

    {:reply, {:ok, payload}, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug "> leave #{ inspect reason }"

    :ok
  end
end
