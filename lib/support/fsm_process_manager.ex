defmodule FsmProcessManager do
  defmacro __using__(opts) do
    quote do
      import Kernel, except: [apply: 2]

      use Fsm, initial_state: unquote(opts[:initial_state])

      def handle(%__MODULE__{state: nil} = fsm, event), do: __MODULE__.handle(__MODULE__.new, event)
      def handle(%__MODULE__{} = fsm, event) do
        fsm
        |> __MODULE__.on(event)
        |> __MODULE__.data  # commands extracted from the FSM's data
      end

      def apply(%__MODULE__{state: nil} = fsm, event), do: __MODULE__.apply(__MODULE__.new, event)
      def apply(%__MODULE__{} = fsm, event) do
        state =
          fsm
          |> __MODULE__.on(event)
          |> __MODULE__.state

        # extract and return just the FSM's state
        %__MODULE__{state: state}
      end
    end
  end
end
