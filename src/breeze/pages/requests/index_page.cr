class Breeze::Requests::IndexPage < BreezeLayout
  needs pages : Lucky::Paginator
  needs breeze_requests : BreezeRequestQuery

  def page_title : String
    "All Requests"
  end

  def content
    render_table
  end

  def render_table
    mount Breeze::Panel do
      ul class: "-mt-px" do
        @breeze_requests.each do |req|
          request_row(req)
        end
      end

      mount Breeze::PageNav, pages: @pages
    end
  end

  def request_row(req)
    li class: "border-t border-gray-200" do
      link class: "block hover:bg-gray-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out", to: Show.with(req.id) do
        div class: "flex items-center px-4 py-4 sm:px-4" do
          div class: "min-w-0 flex-1 flex items-center" do
            div class: "min-w-0 flex-1 px-4 md:grid md:grid-cols-3 md:gap-4" do
              div { mount Breeze::Badge, req: req }
              div class: "hidden md:block" do
                div req.action, class: "text-sm leading-5 text-indigo-700 truncate"
              end
              div class: "hidden md:block" do
                div class: "text-sm leading-5 text-gray-500" do
                  text "#{time_ago_in_words(req.created_at)} ago"
                end
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
