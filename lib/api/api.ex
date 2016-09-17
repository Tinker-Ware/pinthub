defmodule PintHub.API do
  alias PintHub.Model.User
  use HTTPotion.Base

  def process_url(url) do
    "https://api.github.com/users/" <> url
  end
end
