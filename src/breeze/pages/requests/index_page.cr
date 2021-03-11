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
      ul class: "mt-1 divide-y divide-gray-200" do
        breeze_requests.each do |req|
          request_row(req)
        end
      end

      mount Breeze::Pagination, pages: pages
    end
  end

  def request_row(req)
    li do
      link to: Requests::Show.with(req.id), class: "block hover:bg-indigo-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out" do
        div class: "flex items-center px-4 py-4 sm:px-4" do
          div class: "min-w-0 flex-1 flex items-center" do
            div class: "min-w-0 flex-1 px-4 sm:grid grid-cols-3 md:grid-cols-4 gap-6" do
              div class: "font-mono" { mount Breeze::Badge, req }
              div class: "hidden sm:block" do
                div req.action, class: "text-sm font-mono leading-5 text-indigo-700 truncate"
              end
              div class: "text-sm leading-5 text-gray-500 mt-2 sm:mt-0" do
                text "#{time_ago_in_words(req.created_at)} ago"
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
