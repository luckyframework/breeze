class Breeze::BreezePipe < Breeze::BreezeBaseModel
  table :breeze_pipes do
    column name : String
    column continued : Bool
    belongs_to breeze_request : BreezeRequest
  end
end
