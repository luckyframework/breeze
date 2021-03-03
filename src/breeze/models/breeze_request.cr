class BreezeRequest < BreezeBaseModel
  table do
    column path : String
    column method : String
    column action : String
    column body : String?
    column parsed_params : JSON::Any
    column session : JSON::Any
    column headers : JSON::Any
    has_one breeze_response : BreezeResponse?
    has_many breeze_sql_statements : BreezeSqlStatement
    has_many breeze_pipes : BreezePipe
  end

  def method : String
    previous_def.upcase
  end
end
