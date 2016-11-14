defmodule PintHub.Client do
  @moduledoc """
  PintHub Client Module.
  """
  @scheme "https"
  @base_url "api.github.com"

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
  defp call(path, method, %{token: token, parameters: parameters}) do
    request(method, gen_endpoint(path, parameters), [], headers(token), [])
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

  defp response({:ok, %HTTPoison.Response{status_code: code} = resp})
                                                        when code in 200..299 do
    {:ok, %{response: Poison.decode!(resp.body, keys:
      :string), information: get_header_information(resp.headers)}}
  end
  defp response({:ok, %HTTPoison.Response{status_code: code} = resp})
                                                        when code in 300..599 do
    {:error, %{response: Poison.decode!(resp.body, keys:
      :string), information: get_header_information(resp.headers)}}
  end
  defp response({:error, error}),
    do: {:error, error.reason}

  defp headers(token) do
    %{"Content-Type" => "application/json", "User-Agent" => "pinthub",
      "Authorization" => "Bearer #{token}"}
  end
  defp headers do
    %{"Content-Type" => "application/json", "User-Agent" => "pinthub"}
  end

  defp gen_endpoint(path, opts \\ %{}) do
    query = URI.encode_query(opts)
    URI.to_string(%URI{scheme: @scheme, host: @base_url,
                  path: path, query: query})
  end

  defp get_header_information(headers) do
    %{}
    |> rate_limit(headers)
  end

  defp rate_limit(information, headers) do
    %{"X-RateLimit-Limit" => limit, "X-RateLimit-Remaining" => remaining,
      "X-RateLimit-Reset" => reset} = List.foldl(headers, %{}, fn({key, value}, acc) -> Map.put(acc, key, value) end)

    information
    |> Map.put(:rate, %{limit: limit, remaining: remaining, reset: reset})
  end
end
