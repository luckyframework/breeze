class Breeze::Requests::Show < Breeze::BreezeAction
  get "/requests/:request_id" do
    breeze_request = if request_id == "last"
                       breeze_request_query.created_at.asc_order.last
                     else
                       breeze_request_query.find(request_id)
                     end
    html ShowPage, breeze_request: breeze_request
  end

  private def breeze_request_query : BreezeRequestQuery
    BreezeRequestQuery.new
      .preload_breeze_response
      .preload_breeze_sql_statements
      .preload_breeze_pipes
  end
end
