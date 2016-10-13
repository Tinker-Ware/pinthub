defmodule PintHub.OAUTHTest do
  use ExUnit.Case
  doctest PintHub

  alias PintHub.OAUTH

  @valid_attrs %{scope: ["repo", "user:follow"], allow_signup: true,
  redirect_uri: "http://localhost.com", state: "iamastate"}

  test "get the oauth url" do
    url = OAUTH.get_oauth_url(@valid_attrs)
    assert url == "https://github.com/login/oauth/authorize?allow_signup=true&client_id=some_id&redirect_uri=http%3A%2F%2Flocalhost.com&scope=repo+user%3Afollow&state=iamastate"
  end

end
