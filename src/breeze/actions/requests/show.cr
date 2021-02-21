class Breeze::Requests::Show < BreezeAction
  get "/requests/:request_id" do
    html ShowPage, breeze_request: BreezeRequestQuery.find(request_id)
  end
end
