defmodule EvSim.Registration.Events do
  defmodule OrderPlaced,
    do: defstruct [uuid: nil, conference_id: nil, seats: [], reservation_auto_expiration: nil, access_code: nil]
  defmodule OrderConfirmed,         
    do: defstruct [uuid: nil]
  defmodule OrderExpired,           
    do: defstruct [uuid: nil]
  defmodule OrderPartialyReserved, 
    do: defstruct [uuid: nil, reservation_expiration: nil, seats: []]
  defmodule OrderPayementConfirmed, 
    do: defstruct [uuid: nil]
  defmodule OrderPlaced,
    do: defstruct [uuid: nil, conference_id: nil, seats: [],
                   reservation_auto_expiration: nil, access_code: nil]
  defmodule OrderRegistrationAssigned,
    do: defstruct [uuid: nil, first_name: nil, last_name: nil, email: nil]
  defmodule OrderRegistrationCompleted, 
    do: defstruct [uuid: nil, reservation_expiration: nil, seats: []]
  defmodule OrderTotalsCalculated,
    do: defstruct [uuid: nil, total: nil, lines: [], is_free_of_charge: nil]
  defmodule OrderUpdated,
    do: defstruct [uuid: nil, seats: []]

end
