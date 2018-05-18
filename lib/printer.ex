defmodule Babylon.Printer do
  @moduledoc """
  Defines the Printer consumer. It is responsible for receiving a list
  of numbers and printing them to screen in 1 second intervals
  """
  use GenStage

  @doc """
  Start a Printer stage linked to Multiplier which does not track state
  """
  def start_link() do
    GenStage.start_link(__MODULE__, :state_not_applicable)
  end

  @doc """
  Sets up Printer as a GenStage Consumer

      iex> Printer.init("state")
      {:consumer, "state"}
  """
  def init(state) do
    {:consumer, state}
  end

  @doc """
  Handle incoming lists of numbers by simply printing them to screen every 1
  second.

      iex> Printer.handle_events([1, 2, 3], nil, :state_not_applicable)
      [1, 2, 3]
      {:noreply, [], :state_not_applicable}
  """
  def handle_events(events, _from, state) do
    Process.sleep(1000)
    IO.inspect(events)
    {:noreply, [], state}
  end
end
