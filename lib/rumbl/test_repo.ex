defmodule Rumbl.TestRepo do
  @moduledoc """
  In-memory repository.
  """

  alias Rumbl.Accounts.User

  def all(User) do
    [
      %User{id: "1", name: "Jose", username: "josevalim", password: "elixir"},
      %User{id: "2", name: "Bruce", username: "redrapids", password: "7langs"},
      %User{id: "3", name: "Chris", username: "chrismccord", password: "phx"}
    ]
  end

  def all(_module), do: []

  def get(User, id) do
    Enum.find(all(User), fn user -> user.id == id end)
  end

  def get(_module, _id), do: nil

  def get_by(User, params) do
    Enum.find(all(User), fn user ->
      Enum.all?(params, fn {key, val} -> Map.get(user, key) == val end)
    end)
  end

  def get_by(_module, _params), do: nil
end
