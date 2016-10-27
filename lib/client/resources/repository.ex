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

  @doc """
    Parameters:
      - visibility: Can be one of all, public, or private. Default: all
      - affiliation: string	Comma-separated list of values. Can include:
            * owner: Repositories that are owned by the authenticated user.
            * collaborator: Repositories that the user has been added to as a collaborator.
            * organization_member: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.

            Default: owner,collaborator,organization_member
      - type: Can be one of all, owner, public, private, member. Default: all
        Will cause a 422 error if used in the same request as visibility or affiliation.
      - sort: string	Can be one of created, updated, pushed, full_name. Default: full_name
      - direction: Can be one of asc or desc. Default: when using full_name: asc; otherwise desc
      - per_page: used to limit the number of results retrieved, up to 100.
      - page: used to advance in the pagination.
  """
  def list_repos(token) do
    get("/user/repos", %{token: token})
  end
  def list_repos(token, parameters) do
    get("/user/repos", %{token: token, parameters: parameters})
  end
end
