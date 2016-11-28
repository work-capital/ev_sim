defmodule EvSim.ProcessManager.Manager do
  @moduledoc """
  TODO: how to send %ExpireOrder{} to a scheduller ?
  process manager should receive commands ?
  """

  # EVENTS
  alias EvSim.Order.Events.{OrderPlaced}
  alias EvSim.Payment.Events.{PaymentReceived}
  alias EvSim.Conference.Events.{ReservationAccepted, ReservationRejected}

  # COMMANDS
  alias EvSim.Order.Commands.{RegisterToConference, RejectOrder, MarkOrderAsBooked}
  alias EvSim.Conference.Commands.{MakeSeatReservation, CancelSeatReservation, CommitSeatReservation}
  alias EvSim.ProcessManager.Commands.{ExpireOrder}
  alias EvSim.Payment.Commands.{MakePayment}

  use FsmProcessManager, initial_state: :non_started

  # Commanded process manager routing
  def interested?(%OrderPlaced{uuid: uuid}), do: {:start, uuid}
  def interested?(%ReservationAccepted{uuid: uuid}), do: {:continue, uuid}
  def interested?(%ReservationRejected{uuid: uuid}), do: {:continue, uuid}
  def interested?(%PaymentReceived{uuid: uuid}), do: {:continue, uuid}

  # NON-STARTED
  defstate non_started do

    defevent on(%OrderPlaced{uuid: uuid} = order) do
       next_state(:awaiting_reservation, [%MakeSeatReservation{uuid: uuid}])
    end

    defevent _, do: respond(:error)
  end

  # AWAITING RESERVATION CONFIRMATION
  defstate awaiting_reservation do

    defevent on(%ReservationAccepted{uuid: id} = reservation) do
      next_state(:awaiting_payment, [%MarkOrderAsBooked{}, %ExpireOrder{}])
    end

    defevent on(%ReservationRejected{} = reservation) do
      next_state(:completed, %RejectOrder{})
    end

    defevent _, do: respond(:error)
  end

  # AWAITING PAYMENT
  defstate awaiting_payment do

    defevent on(%OrderPlaced{} = order) do
      next_state(:completed, [%CancelSeatReservation{}, %RejectOrder{}])
    end

    defevent on(%PaymentReceived{} = payment) do
      next_state(:completed, [%CommitSeatReservation{}])
    end

    defevent _, do: respond(:error)
  end

  # COMPLETED
  defstate completed do
    defevent _, do: respond(:error)
  end
end
