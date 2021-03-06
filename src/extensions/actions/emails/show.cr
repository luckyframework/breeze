class Breeze::Emails::Show < BreezeAction
  param plain_format : Bool = false

  get "/emails/:email_key" do
    email = Breeze.settings.email_previews.find(email_key)
    html ShowPage, email: email, email_key: email_key, plain_format: plain_format
  end
end
