defmodule Postit.Markdown do
  @moduledoc """
  Convenent Markdown transform.
  """
  use Phoenix.HTML
  require Logger

  def transform_html(body) do
    body
    |> Earmark.as_html!()
    |> raw()
  end
end
