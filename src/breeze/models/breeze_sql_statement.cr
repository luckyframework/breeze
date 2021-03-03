class BreezeSqlStatement < BreezeBaseModel
  table do
    column statement : String
    column args : String?
    column model : String?
    belongs_to breeze_request : BreezeRequest?
  end
end
