defmodule Postit.Markdown do
  @moduledoc """
  Convenent Markdown transform.
  """

  def transform_html(body) do
    body
    |> Earmark.as_html!()
  end
end
