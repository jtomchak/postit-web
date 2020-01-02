defmodule LinkHelper do
  @doc """
  Returns the string in the 3rd argument if the expected controller
  matches the Phoenix controller that is extracted from conn. If no 3rd
  argument is passed in then it defaults to "active".

  Use like this:
  <%= link "Users", to: user_path(@conn, :index), class: active_class(@conn, user_path(@conn, :index))%>

  """
  # def active_link(conn, path, opts) do
  #   class =
  #     [opts[:class], active_class(conn, path)]
  #     |> Enum.filter(& &1)
  #     |> Enum.join(" ")

  #   opts =
  #     opts
  #     |> Keyword.put(:class, class)
  #     |> Keyword.put(:to, path)

  #   link(text, opts)
  # end

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "text-center block border border-blue-500 rounded py-2 px-4 bg-blue-500 hover:bg-blue-700 text-white"
    else
      "text-center block border border-white rounded hover:border-gray-200 text-blue-500 hover:bg-gray-200 py-2 px-4"
    end
  end
end
