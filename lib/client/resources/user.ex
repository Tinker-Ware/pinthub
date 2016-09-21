defmodule PintHub.Resource.User do
  @moduledoc """
    Github `Users` resource API calls.
  """

  import PintHub.Client

  @doc """
    Get user information, receives the username to be retrieved
  """
  def get_user(username) do
    get("/users/#{username}")
  end
end
