class BreezeCarbon::Emails::Index < BreezeAction
  get "/emails" do
    emails = BreezeCarbon.settings.email_previews.new
    html IndexPage, emails: emails.previews
  end
end
