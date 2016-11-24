defmodule EvSim.Order.Events do
  defmodule OrderCreated,
    do: defstruct [uuid: nil, conference_id: nil, seats: [], reservation_auto_expiration: nil, access_code: nil]

end
