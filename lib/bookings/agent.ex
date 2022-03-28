defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  use Agent

  def start_link(_initial_state), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &upsert_state(&1, booking))

  def get(id), do: Agent.get(__MODULE__, &get_by_state(&1, id))

  defp get_by_state(state, id) do
    case Map.get(state, id) do
      nil -> {:error, :not_found}
      booking -> {:ok, booking}
    end
  end

  defp upsert_state(state, %{id: id} = booking), do: Map.put(state, id, booking)
end
