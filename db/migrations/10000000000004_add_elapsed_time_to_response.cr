class AddElapsedTimeToResponse::V20210710193748 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(BreezeResponse) do
      add elapsed_text : String, fill_existing_with: "N/A"
    end
  end

  def rollback
    alter table_for(BreezeResponse) do
      remove :elapsed_text
    end
  end
end
