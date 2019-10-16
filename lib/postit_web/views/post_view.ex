defmodule PostitWeb.PostView do
  use PostitWeb, :view

  def markdown(body) do
    body
    |> Earmark.as_html!()
    |> raw
  end
end
