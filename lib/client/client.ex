defmodule PintHub.Client do
  @moduledoc """
  PintHub Client Module.
  """

  import HTTPoison, only: [request: 5]

  @doc """
  HTTP GET request to Github API
  """
  def get(path, opts \\ %{}),
    do: call(path, :get, opts)

  @doc """
  HTTP POST request to Github API
  """
  def post(path, opts \\ %{}),
    do: call(path, :post, opts)

  @doc """
  HTTP PUT request to Github API
  """
  def put(path, opts \\ %{}),
    do: call(path, :put, opts)

  @doc """
  HTTP DELETE request to Github API
  """
  def delete(path, opts \\ %{}),
    do: call(path, :delete, opts)

  @doc """
  Fetch only body from response
  """
  def body!({:ok, resp}),
    do: resp.body
  def body!({:error, err}),
    do: err

  defp call(path, method, %{request_body: request_body, token: token}) do
    body = Poison.encode!(request_body)
    request(method, gen_endpoint(path), body, headers(token), [])
    |> response
  end
  defp call(path, method, %{token: token}) do
    request(method, gen_endpoint(path), [], headers(token), [])
    |> response
  end
  defp call(path, method, _opts) do
    request(method, gen_endpoint(path), [], headers, [])
    |> response
  end

  defp response({:ok, %HTTPoison.Response{body: nil} = resp}),
    do: {:ok, %{body: nil, headers: resp.headers, status: resp.status_code}}
  defp response({:ok, resp}) do
    {:ok, %{body: Poison.decode!(resp.body, keys:
      :string),
      headers: resp.headers, status: resp.status_code}}
  end
  defp response({:error, error}),
    do: {:error, error.reason}

  defp headers(token) do
    %{"Content-Type" => "application/json", "User-Agent" => "pinthub",
      "Authorization" => token}
  end
  defp headers do
    %{"Content-Type" => "application/json", "User-Agent" => "pinthub"}
  end

  defp gen_endpoint(path),
    do: "https://api.github.com" <> path
end
