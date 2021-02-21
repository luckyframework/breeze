class BreezeRequest < BreezeBaseModel
  table do
    column path : String
    column method : String
    column action : String
    column status : Int32
    column session : JSON::Any
    column headers : JSON::Any
  end

  def method : String
    previous_def.upcase
  end
end
