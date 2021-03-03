class Breeze::Emails::Show < BreezeAction
  param plain : Bool = false

  get "/emails/:email_name" do
    email = Breeze.settings.email_previews.find(email_name)
    if plain
      if text_body = email.text_body
        plain_text(text_body, status: 200)
      else
        render_missing_template_error(email, "text")
      end
    else
      if html_body = email.html_body
        send_text_response(
          html_body,
          content_type: "text/html",
          status: 200
        )
      else
        render_missing_template_error(email, "html")
      end
    end
  end

  private def render_missing_template_error(email : Carbon::Email, template : String)
    plain_text(<<-MESSAGE, status: 400)
    The email #{email.class} does not have
    a #{template} template email setup.

    Try this...
      1. In your #{email.class}, add `#{template}` to your `templates` - templates html, text
      2. Add a `#{template}.ecr` file in src/emails/templates/#{email.class.name.underscore}/#{template}.ecr
    MESSAGE
  end
end
