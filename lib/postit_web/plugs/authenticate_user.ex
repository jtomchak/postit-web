defmodule PostitWeb.Plugs.AuthenticateUser do

import Plug.Conn
import Phoenix.Controller 

def init(_params) do
end


@moduledoc """
Method used to secure an endpoint by ensuring there is a current user from get_session
"""
  def call(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
      nil ->
        conn 
        |> redirect(to: "/auth/auth0") 
        |> halt # what's halt?
      _ ->
        conn
        |> assign(:current_user, user)
    end
  end


end