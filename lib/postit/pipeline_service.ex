defmodule Postit.Pipeline do
  import Logger
  @url "http://45.33.47.252/api/build"

  @moduledoc """
  Calling Postit CICD Service for Builds through the pipeline. 
  Don't want to make API calls from dev. Thus the case match
  """
  def start_pipeline(username) do
    headers = ["Content-Type": "application/json"]

    case Mix.env() do
      :dev -> Logger.info("HTTP POST to build server: #{username}")
      _ -> HTTPoison.post(@url, post_body(username), headers)
    end
  end

  defp post_body(username) do
    %{
      "build" => %{
        "username" => username,
        "title" => "Jesse Tomchak Blog"
      }
    }
    |> Poison.encode!()
  end
end
