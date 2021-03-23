class Breeze::BreezeSqlStatement < Breeze::BreezeBaseModel
  table :breeze_sql_statements do
    column statement : String
    column args : String?
    column model : String?
    column elapsed_text : String
    belongs_to breeze_request : BreezeRequest?
  end
end
