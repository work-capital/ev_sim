defmodule EvSim.Payment.Events do
  defmodule PaymentAccepted,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
  defmodule PaymentReceived,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
  defmodule PaymentInitiated,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
  defmodule PaymentRejected,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
end
