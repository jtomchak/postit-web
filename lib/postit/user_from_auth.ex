defmodule UserFromAuth do
  @moduledoc """
  Retrieve the user informatio8n from the auth request  
  """
  require Logger
  require Poison

  alias Ueberauth.Auth 

  def find_or_create(%Auth{provider: :identity} = auth) do # pattern matching auth from the arg passed in?
    case validate_pass(auth.credentials) do
      :ok ->
        {:ok, basic_info(auth)} #return is a record or a tuple?
        {:error, reason} -> {:error, reason}
    end
  end

  def find_or_create(%Auth{} = auth) do # why do i have two functions one with an auth record and one without?
    {:ok, basic_info(auth)}
  end

  # Github does it this way
  defp avatar_from_auth( %{info: %{urls: %{avatar_url: image}} }), do: image

  # default case if nothing matches
  defp avatar_from_auth( auth ) do
    Logger.warn("#{auth.provider} needs to find an avatar URL pretty please!")
    Logger.debug(Poison.encode!(auth)) # What is poison doing?
    nil # what is the return nil? and what on earth is defp versus def, and the 'do: image'?
  end

  defp basic_info(auth) do
    %{id: auth.uid, name: name_from_auth(auth), avatar: avatar_from_auth(auth)}
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else 
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != "")) # I can understand the logic, but the detail of the '&' ?

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end

  defp validate_pass(%{other: %{password: ""}}) do # need to figure out the '%' meaning and nested {{}}
    {:error, "Password Required Please"}
  end

  defp validate_pass(%{other: %{password: pw, password_confirmation: pw}}) do
    :ok
  end

  defp validate_pass(%{other: %{password: _}}) do
    {:error, "Passwords do not match"}
  end

  defp validate_pass(_), do: {:error, "Password Required"}

end