class Breeze::Requests::Show < Breeze::BreezeAction
  get "/requests/:request_id" do
    breeze_request = BreezeRequestQuery.new
      .preload_breeze_response
      .preload_breeze_sql_statements
      .preload_breeze_pipes
      .find_specific_or_last(request_id)
    html ShowPage, breeze_request: breeze_request
  end
end
