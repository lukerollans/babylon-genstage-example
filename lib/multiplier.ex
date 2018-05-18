defmodule Babylon.Multiplier do
  @moduledoc """
  Defines the Multiplier producer consumer. It is responsible for demanding
  a list of numbers, multiplying them by the given factor, and producing
  the resultant modified list
  """
  use GenStage

  def start_link(factor) do
    GenStage.start_link(__MODULE__, factor)
  end

  @doc """
  Sets up Multiplier as a GenStage Consumer Producer

      iex> Multiplier.init(50)
      {:producer_consumer, 50}
  """
  def init(factor) do
    {:producer_consumer, factor}
  end

  @doc """
  Handle incoming lists of numbers, multiply them by the given factor
  which is stored in state and produce the resultant list

      iex> Multiplier.handle_events([1, 2, 3], nil, 5)
      {:noreply, [5, 10, 15], 5}
  """
  def handle_events(events, _from, factor) do
    events = Enum.map(events, & &1 * factor)
    {:noreply, events, factor}
  end
end
