defmodule PintHub.OAUTH do
  @moduledoc """
    Github `OAUTH` related functionality
    [Github OAUTH](https://developer.github.com/v3/oauth/)
  """
  @base_url "https://github.com/login/oauth/authorize"

  @doc """
    Generates the oauth URL for Github, receives the following options:
    - redirect_uri: The URL in your application where users will be sent after authorization. See details below about redirect urls.
    - scope: A space delimited list of scopes. If not provided, scope defaults to an empty list for users that have not authorized any scopes for the application. For users who have authorized scopes for the application, the user won't be shown the OAuth authorization page with the list of scopes. Instead, this step of the flow will automatically complete with the set of scopes the user has authorized for the application. For example, if a user has already performed the web flow twice and has authorized one token with user scope and another token with repo scope, a third web flow that does not provide a scope will receive a token with user and repo scope.
    - state: An unguessable random string. It is used to protect against cross-site request forgery attacks.
    - allow_signup: Whether or not unauthenticated users will be offered an option to sign up for GitHub during the OAuth flow. The default is true. Use false in the case that a policy prohibits signups.
  """
  def get_oauth_url(%{scope: scope} = opts  \\ []) do
    client_id = Application.fetch_env!(:pinthub, :client_id)

    sp = Enum.join(scope, " ")
    opts =
      opts
      |> Map.put(:scope, sp)
      |> Map.put(:client_id, client_id)
    uri = URI.encode_query(opts)

    URI.to_string(%URI{scheme: "https", host: "github.com", path: "/login/oauth/authorize",
                  query: uri})
  end

  @doc """
  Gets the OAuth token from Github
  """
  def exchange_token(code) do

  end
end
