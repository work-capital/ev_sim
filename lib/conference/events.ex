defmodule EvSim.Conference.Events do
  defmodule ReservationAccepted,
    do: defstruct [uuid: nil]
  defmodule ReservationRejected,
    do: defstruct [uuid: nil]
  defmodule ConferenceEvent,
    do: defstruct [uuid: nil, name: nil, desc: nil, location: nil, slug: nil,
                   tagline: nil, start_date: nil, end_date: nil, owner: nil]
  defmodule ConferencePublished, 
    do: defstruct [uuid: nil]
  defmodule ConferenceUnpublished, 
    do: defstruct [uuid: nil]
  defmodule ConferenceUpdated,
    do: defstruct [uuid: nil]
end
