defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.Upsert, as: UserUpsert
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Upsert, as: BookingUpsert

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate upsert_user(params), to: UserUpsert, as: :call
  defdelegate upsert_booking(params), to: BookingUpsert, as: :call
end
