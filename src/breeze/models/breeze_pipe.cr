class Breeze::BreezePipe < Breeze::BreezeBaseModel
  table :breeze_pipes do
    column name : String
    column continued : Bool
    column position : String
    belongs_to breeze_request : BreezeRequest
  end
end
