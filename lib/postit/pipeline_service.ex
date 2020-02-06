defmodule Postit.Pipeline do
  @url "http://45.33.47.252/api/build"

  @moduledoc """
  Calling Postit CICD Service for Builds through the pipeline. 
  """
  def start_pipeline(username) do
    headers = ["Content-Type": "application/json"]
    HTTPoison.post(@url, post_body(username), headers)
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
