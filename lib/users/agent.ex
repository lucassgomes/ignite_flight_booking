defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(_initial_state), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%User{} = user), do: Agent.update(__MODULE__, &upsert_state(&1, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_by_state(&1, cpf))

  defp get_by_state(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  defp upsert_state(state, %{cpf: cpf} = user), do: Map.put(state, cpf, user)
end
