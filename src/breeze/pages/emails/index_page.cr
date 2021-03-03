class Breeze::Emails::IndexPage < BreezeLayout
  needs emails : Carbon::EmailPreviews::EmailLookup

  def page_title : String
    "All Emails"
  end

  def content
    render_table
  end

  def render_table
    mount Breeze::Panel do
      ul class: "mt-1 divide-y divide-gray-200" do
        emails.each do |key, email|
          email_row(key, email)
        end
      end
    end
  end

  def email_row(key : String, email : Carbon::Email)
    li do
      link to: Emails::Show.with(key), class: "block hover:bg-indigo-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out" do
        div class: "flex items-center px-4 py-4 sm:px-4" do
          div class: "min-w-0 flex-1 flex items-center" do
            div class: "min-w-0 flex-1 px-4 sm:grid grid-cols-3 md:grid-cols-4 gap-6" do
              div class: "hidden sm:block" do
                div email.class.name, class: "text-sm font-mono leading-5 text-indigo-700 truncate"
              end
            end
          end
          div do
            mount RowArrow
          end
        end
      end
    end
  end
end
