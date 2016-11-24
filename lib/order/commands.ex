defmodule EvSim.Order.Commands do
  defmodule RegisterToConference,
    do: defstruct [uuid: nil, seats: nil, reservation_id: nil]
  defmodule RejectOrder,
    do: defstruct [uuid: nil, conference_id: nil, seats: [], reservation_auto_expiration: nil, access_code: nil]
  defmodule MarkOrderAsBooked,
    do: defstruct [uuid: nil, conference_id: nil, seats: [], reservation_auto_expiration: nil, access_code: nil]

end
