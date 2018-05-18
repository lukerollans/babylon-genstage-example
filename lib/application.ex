defmodule Babylon.Application do
  @moduledoc """
  Defines the OTP application behaviour of :babylon
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Start first job at 1
    {:ok, incrementer} = Babylon.Incrementer.start_link(100)

    # Set multiplcation factor to 3
    {:ok, multiplier} = Babylon.Multiplier.start_link(3)

    # Start printer with no state
    {:ok, printer} = Babylon.Printer.start_link()

    children = []
    opts = [strategy: :one_for_one, name: Babylon.Supervisor]

    GenStage.sync_subscribe(multiplier, to: incrementer, min_demand: 5, max_demand: 10)
    GenStage.sync_subscribe(printer, to: multiplier)

    Supervisor.start_link(children, opts)
  end
end
