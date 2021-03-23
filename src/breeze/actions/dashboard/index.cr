class Breeze::Dashboard::Index < Breeze::BreezeAction
  get "/" do
    redirect to: Breeze::Requests::Index
  end
end
