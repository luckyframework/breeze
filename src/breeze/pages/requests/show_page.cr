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
    mount Breeze::DescriptionList,
      heading_title: ->{ text req.action },
      heading_subtitle: ->{ mount Breeze::Badge, req: req },
      list: ->{
        mount Breeze::DescriptionListRow, key: "Status", value: req.status.to_s
        render_session_info
        render_header_info
      }
  end

  def render_session_info
    req.session.as_h.each do |key, value|
      mount Breeze::DescriptionListRow, key: "Session #{key}", value: value.as_s
    end
  end

  def render_header_info
    req.headers.as_h.each do |key, value|
      mount Breeze::DescriptionListRow, key: "Header #{key}", value: value[0].as_s
    end
  end
end
