defmodule Flightex.Bookings.Booking do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_cpf) do
    case UserAgent.get(user_cpf) do
      {:ok, %User{id: user_id}} ->
        {:ok,
         %__MODULE__{
           id: UUID.uuid4(),
           complete_date: complete_date,
           local_origin: local_origin,
           local_destination: local_destination,
           user_id: user_id
         }}

      {:error, :not_found} ->
        {:error, :user_not_found}

      _ ->
        {:error, :unknow}
    end
  end
end
