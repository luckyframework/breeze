class Breeze::Requests::ShowPage < Breeze::BreezeLayout
  needs breeze_request : BreezeRequest

  def page_title : String
    "Request Details"
  end

  def req : BreezeRequest
    breeze_request
  end

  def breadcrumb_parent
    link "All Requests", to: Index, class: "border-b-2 border-green-400 hover:text-teal-700"
    mount RowArrow, html_class: "mx-1 mb-1 h-5 w-5 text-gray-400 inline-block"
  end

  def content
    div class: "w-2/3" do
      mount Breeze::Panel do
        mount Breeze::DescriptionList do |c|
          c.heading_title do
            mount Breeze::Badge, req, large: true
            span class: "ml-3 font-normal text-base text-blue-800" do
              text "about #{time_ago_in_words(req.created_at)} ago"
            end
          end
          c.list do
            mount Breeze::DescriptionListRow, "Action", req.action
            req.breeze_response.try do |resp|
              mount Breeze::DescriptionListRow, "Response Status", "#{resp.status} #{Wordsmith::Inflector.humanize(HTTP::Status.from_value?(resp.status))}"
            end
            mount Breeze::DescriptionListRow, "Request Body", req.body || "No body"
            mount Breeze::DescriptionListRow, "Request Params", req.parsed_params.to_s || "No params"
          end
        end
      end
      mount Breeze::Panel do
        mount Breeze::DescriptionList do |c|
          c.heading_title do
            text "Session"
          end
          c.list do
            render_session_info
          end
        end
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList do |c|
          c.heading_title do
            text "Queries"
          end
          c.list do
            if req.breeze_sql_statements.any?
              req.breeze_sql_statements.each do |query|
                render_query_row(query)
              end
            else
              para "No queries", class: "text-center text-gray-500 px-10 py-8 max-x-sm"
            end
          end
        end
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList do |c|
          c.heading_title do
            text "Pipes"
          end
          c.list do
            req.breeze_pipes.each do |pipe|
              mount Breeze::DescriptionListRow, "Foo", pipe.name
            end
          end
        end
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList do |c|
          c.heading_title do
            text "Request Headers"
          end
          c.list do
            render_request_header_info
          end
        end
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList do |c|
          c.heading_title do
            text "Response Headers"
          end
          c.list do
            render_response_header_info
          end
        end
      end
    end
  end

  def render_session_info
    req.session.as_h.each do |key, value|
      mount Breeze::DescriptionListRow, "Session #{key}", value.as_s
    end
  end

  def render_request_header_info
    req.headers.as_h.each do |key, value|
      mount Breeze::DescriptionListRow, "Header #{key}", value[0].as_s
    end
  end

  def render_response_header_info
    req.breeze_response.try do |resp|
      resp.headers.as_h.each do |key, value|
        mount Breeze::DescriptionListRow, "Header #{key}", value[0].as_s
      end
    end
  end

  def render_query_row(query : BreezeSqlStatement)
    link_styles = "block sm:border-t sm:border-gray-200 hover:bg-indigo-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out"

    link to: Queries::Show.with(query.id), class: link_styles do
      div class: "flex items-center px-4 py-4 sm:px-4" do
        div class: "min-w-0 flex-1 flex items-center" do
          div class: "min-w-0 flex-1 px-4 sm:grid grid-cols-3 md:grid-cols-3 gap-4" do
            div class: "text-sm leading-5 font-medium text-gray-500" { text "#{query.model}Query" }
            div class: "text-sm leading-5 text-gray-500 col-span-2 mt-2 sm:mt-0" do
              text query.statement
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
