defmodule Postit.AuthenticationEmail do
  use Bamboo.Phoenix, view: PostitWeb.EmailView

  import Bamboo.Email

  @doc """
    The sign in email containing the login link.
  """
  def login_link(token_value, user) do
    base_email()
    |> to(user.email)
    |> subject("Your login link")
    |> assign(:token, token_value)
    |> render("login_link.text")
  end

  defp base_email do
    new_email()
    |> from("support@postit.blog")
    |> put_header("Reply-To", "support@postit.blog")

    # This will use the "email.html.eex" file as a layout when rendering html emails.
    # Plain text emails will not use a layout unless you use `put_text_layout`
    # |> put_html_layout({PostitWeb.LayoutView, "email.html"})
  end
end
