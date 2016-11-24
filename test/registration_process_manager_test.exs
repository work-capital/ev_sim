defmodule EvSim.RegistrationProcessManagerTest do
  use ExUnit.Case

  alias EvSim.Order.Events.{OrderPlaced}

  describe "not started" do
    test "should make seat reservation when order placed" do
      commands = EvSim.ProcessManager.Manager.handle(%EvSim.ProcessManager.Manager{}, %OrderPlaced{uuid: "1234"})

      assert commands == [
        %EvSim.Conference.Commands.MakeSeatReservation{uuid: "1234"}
      ]
    end

    test "should transition state to awaiting reservation when order placed" do
      state = EvSim.ProcessManager.Manager.apply(%EvSim.ProcessManager.Manager{}, %OrderPlaced{uuid: "1234"})

      assert state == %EvSim.ProcessManager.Manager{state: :awaiting_reservation}
    end
  end
end
