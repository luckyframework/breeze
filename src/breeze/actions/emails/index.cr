class Breeze::Emails::Index < BreezeAction
  get "/emails" do
    emails = Carbon::Email.email_classes.map(&.name)
    html IndexPage, emails: emails
  end
end
