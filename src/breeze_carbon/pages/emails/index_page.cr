class BreezeCarbon::Emails::IndexPage < Breeze::BreezeLayout
  needs emails : Array(Carbon::Email)

  def page_title : String
    "All Emails"
  end

  def content
    render_table
  end

  def render_table
    mount Breeze::Panel do
      div class: "bg-gray-50 px-4 py-3 flex items-center justify-between border-b border-gray-200 sm:px-6" do
        h2 "Preview Emails", class: "text-xl"
      end
      ul class: "mt-1 divide-y divide-gray-200" do
        emails.each do |email|
          email_row(email)
        end
      end
    end
  end

  def email_row(email : Carbon::Email)
    li do
      div class: "flex items-center px-4 py-4 sm:px-4" do
        div class: "min-w-0 flex-1 flex items-center" do
          div class: "min-w-0 flex-1 px-4 sm:grid grid-cols-3 md:grid-cols-4 gap-6" do
            div class: "hidden sm:block" do
              div email.class.name, class: "text-sm font-mono leading-5 text-indigo-700 truncate"
            end
          end
        end
        div do
          link "HTML", to: Emails::Show.with(slug_for_email(email), plain_format: false), class: format_button_styles
          nbsp
          link "TEXT", to: Emails::Show.with(slug_for_email(email), plain_format: true), class: format_button_styles
        end
      end
    end
  end

  private def slug_for_email(email : Carbon::Email) : String
    email.class.name
  end

  private def format_button_styles : String
    "bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
  end
end
