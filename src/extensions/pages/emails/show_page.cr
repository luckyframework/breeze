class Breeze::Emails::ShowPage < BreezeLayout
  needs email : Carbon::Email
  needs email_key : String
  needs plain_format : Bool

  def page_title : String
    "Carbon Preview - #{email.class.name}"
  end

  def content
    mount Breeze::Panel do
      mount Breeze::DescriptionList,
        heading_title: ->{ text "Email Previews" },
        list: ->{
          mount Breeze::DescriptionListRow, "Subject", email.subject
          mount Breeze::DescriptionListRow, "From", email.from.address
          mount Breeze::DescriptionListRow, "To", email.to.join(", ", &.address)
          email.headers.each do |key, value|
            mount Breeze::DescriptionListRow, key, value
          end
        }
    end
    mount Breeze::Panel do
      div class: "px-4 py-5 border-b border-gray-200 sm:px-6" do
        h3 "Email Body", class: "text-lg leading-6 font-medium text-gray-900"
      end

      iframe src: Breeze::Emails::Render.with(email_key, plain_format: plain_format?).path, class: "w-full h-screen"
    end
  end
end
