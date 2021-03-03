class BreezeResponse < BreezeBaseModel
  table do
    column status : Int32
    column session : JSON::Any
    column headers : JSON::Any
    belongs_to breeze_request : BreezeRequest
  end
end
