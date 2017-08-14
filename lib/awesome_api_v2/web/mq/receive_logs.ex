defmodule ReceiveLogs do
  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts " [x] Received #{payload}"

        wait_for_messages(channel)
    end
  end
end

# {:ok, connection} = AMQP.Connection.open
# {:ok, channel} = AMQP.Channel.open(connection)
# AMQP.Exchange.declare(channel, "mails_exchange", :fanout)
# {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel, "", exclusive: true)
# AMQP.Queue.bind(channel, queue_name, "mails_exchange")
# AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)
# IO.puts " [*] Waiting for messages. To exist press CTRL+C, CTRL+C"

# ReceiveLogs.wait_for_messages(channel)
