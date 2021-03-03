class Breeze::Dashboard::Index < BreezeAction
  get "/" do
    redirect to: Breeze::Requests::Index
  end
end
