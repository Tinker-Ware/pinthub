defmodule PintHub.Resource.Repository do
  @moduledoc """
    Github `Repository` resource API calls.
  """

  import PintHub.Client

  @doc """
    Retrieves all the user repositories
  """
  def list_user_repos(username) do
    get("/users/#{username}/repos")
  end
end
