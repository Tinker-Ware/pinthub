defmodule PintHub.API.User do
  alias PintHub.Model.User
  use HTTPotion.Base

  def process_url(url) do
    "https://api.github.com/users/" <> url
  end

  def process_request_headers(headers) do
    Dict.put headers, :"User-Agent", "github-potion"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!(as: %User{})
  end
end
