defmodule Babylon.Incrementer do
  @moduledoc """
  Defines the Incrementer producer. It is responsible for keeping
  a sequential list of numbers and supplying them when demanded by
  downstream consumers.
  """
  use GenStage

  def start_link(counter) do
    GenStage.start_link(__MODULE__, counter)
  end

  @doc """
  Sets up Incrementer as a GenStage Producer

      iex> Incrementer.init(15)
      {:producer, 15}
  """
  def init(counter) do
    {:producer, counter}
  end

  @doc """
  Handles demand by provuding a non-repating, sequential list
  of numbers

      iex> Incrementer.handle_demand(5, 9)
      {:noreply, [9, 10, 11, 12, 13], 14}
  """
  def handle_demand(demand, counter) when demand > 0 do
    jobs = Enum.to_list(counter..counter+demand-1)
    {:noreply, jobs, counter + demand}
  end
end
