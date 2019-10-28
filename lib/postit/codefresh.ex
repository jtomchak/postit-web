defmodule Postit.Codefresh do
  @auth_token Application.get_env(:postit, :config)[:codefresh_auth_token]
  @pipeline_id Application.get_env(:postit, :config)[:codefresh_pipeline_id]
  @url "https://g.codefresh.io/api/builds/"
  @default_url @url <> @pipeline_id

  @moduledoc """
  Convenent wrapper for build pipeline HTTP calls to Codefresh.
  """
  def trigger_build(username) do
    headers = [Authorization: "Bearer #{@auth_token}", "Content-Type": "application/json"]
    HTTPoison.post(@default_url, post_body(username), headers)
  end

  defp post_body(username) do
    %{
      "serviceId" => @pipeline_id,
      "type" => "build",
      "repoOwner" => "jtomchak",
      "branch" => "master",
      "variables" => %{
        "USERNAME" => username
      }
    }
    |> Poison.encode!()
  end
end
