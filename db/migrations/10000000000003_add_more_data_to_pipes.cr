class AddMoreDataToPipes::V10000000000003 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(BreezePipe) do
      add position : String, fill_existing_with: "N/A"
    end
  end

  def rollback
    alter table_for(BreezePipe) do
      remove :position
    end
  end
end
