defmodule Flightex.Bookings.Upsert do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_cpf: user_cpf
      }) do
    Booking.build(complete_date, local_origin, local_destination, user_cpf)
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}), do: BookingAgent.save(booking)
  defp save_booking({:error, _reason} = error), do: error
end
