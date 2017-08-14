defmodule WelcomeJob do
  def perform(email, user_name) do
    email
      |> AwesomeApiV2.Web.WelcomeEmail.welcome_html_email(user_name)
      |> AwesomeApiV2.Mailer.deliver_now
  end
end
