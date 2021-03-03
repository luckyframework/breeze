class Breeze::Requests::ShowPage < BreezeLayout
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
        mount Breeze::DescriptionList,
          heading_title: ->{
            mount Breeze::Badge, req, large: true
            span class: "ml-3 font-normal text-base text-blue-800" do
              text "about #{time_ago_in_words(req.created_at)} ago"
            end
          },
          list: ->{
            mount Breeze::DescriptionListRow, "Action", req.action
            req.breeze_response.try do |resp|
              mount Breeze::DescriptionListRow, "Response Status", "#{resp.status} #{Wordsmith::Inflector.humanize(HTTP::Status.from_value?(resp.status))}"
            end
            mount Breeze::DescriptionListRow, "Request Body", req.body || "No body"
            mount Breeze::DescriptionListRow, "Request Params", req.parsed_params.to_s || "No params"
          }
      end
      mount Breeze::Panel do
        mount Breeze::DescriptionList,
          heading_title: ->{ text "Session" },
          list: ->{
            render_session_info
          }
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList,
          heading_title: ->{ text "Queries" },
          list: ->{
            if req.breeze_sql_statements.any?
              req.breeze_sql_statements.each do |query|
                mount Breeze::DescriptionListRow, "#{query.model}Query", query.statement
              end
            else
              para "No queries", class: "text-center text-gray-500 px-10 py-8 max-x-sm"
            end
          }
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList,
          heading_title: ->{ text "Pipes" },
          list: ->{
            req.breeze_pipes.each do |pipe|
              mount Breeze::DescriptionListRow, "Foo", pipe.name
            end
          }
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList,
          heading_title: ->{ text "Request Headers" },
          list: ->{
            render_request_header_info
          }
      end

      mount Breeze::Panel do
        mount Breeze::DescriptionList,
          heading_title: ->{ text "Response Headers" },
          list: ->{
            render_response_header_info
          }
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
end
