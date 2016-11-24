defmodule EvSim.ProcessManager.Commands do
  defmodule ExpireOrder,
    do: defstruct [uuid: nil, seats: nil, reservation_id: nil]

end
