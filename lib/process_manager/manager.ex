  defmodule EvSim.ProcessManager.Manager do
    @moduledoc """
    TODO: how to send %ExpireOrder{} to a scheduller ? 
    process manager should receive commands ?
    """
    use Fsm
    # EVENTS
    alias EvSim.Order.Events.{OrderPlaced}
    alias EvSim.Payment.Events.{PaymentReceived}
    alias EvSim.Conference.Events.{ReservationAccepted, ReservationRejected}

    # COMMANDS
    alias EvSim.Order.Commands.{RegisterToConference, RejectOrder, MarkOrderAsBooked}
    alias EvSim.Conference.Commands.{MakeSeatReservation, CancelSeatReservation, CommitSeatReservation}
    alias EvSim.Payment.Commands.{MakePayment}

    # NON-STARTED
    defstate non_started do

      defevent handle(%OrderPlaced{} = order), data: cmds do
         next_state(:awaiting_reservation, cmds ++ [%MakeSeatReservation{}])
      end

      defevent _, do: respond(:error)
    end

    # AWAITING RESERVATION CONFIRMATION
    defstate awaiting_reservation do

      defevent handle(%ReservationAccepted{uuid: id} = reservation), data: cmds do
        next_state(:awaiting_payment, cmds ++ [%MarkOrderAsBooked{}, %ExpireOrder{}])
      end


      defevent handle(%ReservationRejected{} = reservation), data: cmds do
        next_state(:completed, cmds ++ [%RejectOrder{}])
      end

      defevent _, do: respond(:error)

    end

    # AWAITING PAYMENT
    defstate awaiting_payment do

      defevent handle(%OrderPlaced{} = order), data: cmds do
        next_state(:completed, cmds ++ [%CancelSeatReservation{}, %RejectOrder{}])
      end

      defevent handle(%PaymentReceived{} = payment), data: cmds do
        next_state(:completed, cmds ++ [%PaymentReceived{}])
      end

      defevent _,
        do: respond(:error)
    end

    # COMPLETED
    defstate completed do
      defevent _, do: respond(:error)
    end

  end



