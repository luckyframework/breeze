class AddMoreDataToSqlStatements::V10000000000002 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(BreezeSqlStatement) do
      add elapsed_text : String, fill_existing_with: "N/A"
    end
  end

  def rollback
    alter table_for(BreezeSqlStatement) do
      remove :elapsed_text
    end
  end
end
