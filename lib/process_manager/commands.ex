defmodule EvSim.ProcessManager.Commands do
  defmodule PlaceOrder,
    do: defstruct [uuid: nil, conference_id: nil, seats: [], reservation_auto_expiration: nil, access_code: nil]
  defmodule ExpireOrder,
    do: defstruct [uuid: nil, seats: nil, reservation_id: nil]

end
