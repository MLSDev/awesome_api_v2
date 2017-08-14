defmodule ReceiveLogsDirect do
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
# AMQP.Exchange.declare(channel, "direct_logs", :direct)
# {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel, "", exclusive: true)
# |> IO.inspect
# {severities, _, _} = OptionParser.parse(System.argv, strict: [info: :boolean, warning: :boolean, error: :boolean])
# IO.inspect severities

# for {severity, true} <- severities do
#   severity = severity |> to_string
#   IO.puts "binding with #{severity}"
#   AMQP.Queue.bind(channel, queue_name, "direct_logs", routing_key: severity)
#   |> IO.inspect
# end
# AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)
# IO.puts " [*] Waiting for messages. To exist press CTRL+C, CTRL+C"


# ReceiveLogsDirect.wait_for_messages(channel)
