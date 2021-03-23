class Breeze::Requests::Index < Breeze::BreezeAction
  get "/requests" do
    pages, records = paginate(BreezeRequestQuery.new.created_at.desc_order)
    html IndexPage, breeze_requests: records, pages: pages
  end
end
