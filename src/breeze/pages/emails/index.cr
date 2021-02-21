class Breeze::Emails::IndexPage < BreezeLayout
  needs emails : Array(String)

  def page_title : String
    "All Emails"
  end

  def content
    render_table
  end

  def render_table
    mount Breeze::Panel do
      ul class: "-mt-px" do
        emails.each do |email|
          email_row(email)
        end
      end
    end
  end

  def email_row(email)
    li class: "border-t border-gray-200" do
      link class: "block hover:bg-gray-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out", to: Show.with(email) do
        div class: "flex items-center px-4 py-4 sm:px-4" do
          div class: "min-w-0 flex-1 flex items-center" do
            div class: "min-w-0 flex-1 px-4 md:grid md:grid-cols-3 md:gap-4" do
              div class: "hidden md:block" do
                div email, class: "text-sm leading-5 text-indigo-700 truncate"
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
