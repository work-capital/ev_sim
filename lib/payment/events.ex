defmodule EvSim.Payment.Events do
  defmodule PaymentAccepted,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
  defmodule PaymentCompleted,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
  defmodule PaymentInitiated,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
  defmodule PaymentRejected,         
    do: defstruct [uuid: nil, source_id: nil, payment_source_id: nil]
end
