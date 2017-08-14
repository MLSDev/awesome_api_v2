defmodule AwesomeApiV2.Web.WelcomeEmail do
  use Bamboo.Phoenix, view: AwesomeApiV2.Web.EmailView

   def welcome_text_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("dev@mlsdev.com")
    |> subject("Welcome!")
    # |> text_body("Welcome to AwesomeApiV2")
    |> put_text_layout({ AwesomeApiV2.Web.LayoutView, "email.text" })
    |> render("welcome.text")
  end

  def welcome_html_email(email_address, user_name) do
    new_email()
    |> to(email_address)
    |> from("dev@mlsdev.com")
    |> subject("Welcome!")
    |> html_body("<strong>Welcome<strong> to AwesomeApiV2")
    |> put_html_layout({ AwesomeApiV2.Web.LayoutView, "email.html" })
    |> render("welcome.html", user_name: user_name)
  end
end
