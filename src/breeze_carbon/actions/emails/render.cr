class BreezeCarbon::Emails::Render < Breeze::BreezeAction
  param plain_format : Bool = false

  get "/emails/:email_key/render" do
    key = URI.decode_www_form(email_key)
    email = BreezeCarbon.settings.email_previews.find(key)
    if plain_format
      if text_body = email.text_body
        plain_text(text_body, status: 200)
      else
        render_missing_template_error(email, "text")
      end
    else
      if html_body = email.html_body
        pared_markup = parse_body_and_replace_links(html_body)

        send_text_response(
          pared_markup,
          content_type: "text/html",
          status: 200
        )
      else
        render_missing_template_error(email, "html")
      end
    end
  end

  # Scan all links in the email, and add the target _blank
  # This is so you can click on the links, and they don't
  # open up in the iframe.
  private def parse_body_and_replace_links(body : String)
    body.scan(/<a\s*([^>]+)>/) do |match|
      if data = match[1]?
        if data.includes?(%(target=))
          # target is already included
        else
          body = body.sub("<a #{data}", %(<a #{data} target="_blank"))
        end
      end
    end

    body
  end

  private def render_missing_template_error(email : Carbon::Email, template : String)
    plain_text(<<-MESSAGE, status: 400)
    The email #{email.class} does not have
    a #{template} template email setup.

    Try this...
      1. In your #{email.class}, add `#{template}` to your `templates` (e.g. templates html, text)
      2. Add a `#{template}.ecr` file in src/emails/templates/#{email.class.name.underscore}/#{template}.ecr
    MESSAGE
  end
end
