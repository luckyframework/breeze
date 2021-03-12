class Breeze::Emails::Index < BreezeAction
  get "/emails" do
    emails = Breeze.settings.email_previews.new
    html IndexPage, emails: emails.previews
  end
end
