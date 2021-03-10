class Breeze::Queries::ShowPage < BreezeLayout
  needs breeze_sql_statement : BreezeSqlStatement

  def page_title : String
    "Breeze Query"
  end

  def content
    mount Breeze::Panel do
      mount Breeze::DescriptionList,
        heading_title: ->{ text "Query details" },
        list: ->{
          mount Breeze::DescriptionListRow, "Statement", breeze_sql_statement.statement
          mount Breeze::DescriptionListRow, "Args", breeze_sql_statement.args || "[]"
          mount Breeze::DescriptionListRow, "Model", breeze_sql_statement.model || "Unknown"
          mount Breeze::DescriptionListRow, "Elasped Time", breeze_sql_statement.elapsed_text
          mount Breeze::DescriptionListRow, "Query executed", "#{time_ago_in_words(breeze_sql_statement.created_at)} ago"
        }
    end
  end
end
