class BreezeCarbon::Emails::Show < BreezeAction
  param plain_format : Bool = false

  get "/emails/:email_key" do
    key = URI.decode_www_form(email_key)
    email = BreezeCarbon.settings.email_previews.find(key)
    html ShowPage, email: email, email_key: key, plain_format: plain_format
  end
end
