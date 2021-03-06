class Breeze::Emails::ShowPage < BreezeLayout
  needs email : Carbon::Email
  needs email_key : String
  needs plain_format : Bool

  def page_title : String
    "Carbon Preview - #{email.class.name}"
  end

  def content
    mount Breeze::Panel do
      ul class: "mt-1 divide-y divide-gray-200" do
        email_data_row("Subject", email.subject)
        email_data_row("From", email.from.address)
        email_data_row("To", email.to.join(", ", &.address))
        email.headers.each do |key, value|
          email_data_row(key, value)
        end
      end
    end
    div class: "bg-white my-4" do
      iframe src: Breeze::Emails::Render.with(email_key, plain_format: plain_format?).path, class: "w-full h-screen"
    end
  end

  private def email_data_row(title : String, value : String)
    li class: "p-2" do
      span "#{title}:"
      nbsp
      span value
    end
  end
end
