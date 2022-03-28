defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.Upsert, as: UserUpsert

  def start_agents do
    UserAgent.start_link(%{})
  end

  defdelegate upsert(params), to: UserUpsert, as: :call
end
