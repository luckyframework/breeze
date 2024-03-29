class Breeze::Queries::Show < Breeze::BreezeAction
  get "/queries/:query_id" do
    statement = BreezeSqlStatementQuery.new
      .find(query_id)
    html ShowPage, breeze_sql_statement: statement
  end
end
