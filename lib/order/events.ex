defmodule EvSim.Registration.Events do
  defmodule OrderPlaced,
    do: defstruct [uuid: nil, conference_id: nil, seats: [], reservation_auto_expiration: nil, access_code: nil]

end
