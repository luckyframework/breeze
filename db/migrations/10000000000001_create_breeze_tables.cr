class CreateBreezeTables::V10000000000001 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(BreezeRequest) do
      primary_key id : Int64
      add_timestamps
      add path : String
      add method : String
      add action : String
      add headers : JSON::Any
      add body : String?
      add parsed_params : JSON::Any
      add session : JSON::Any
    end

    create table_for(BreezeResponse) do
      primary_key id : Int64
      add_timestamps
      add status : Int32
      add headers : JSON::Any
      add session : JSON::Any
      add_belongs_to breeze_request : BreezeRequest, on_delete: :cascade
    end

    create table_for(BreezeSqlStatement) do
      primary_key id : Int64
      add_timestamps
      add statement : String
      add args : String?
      add model : String?
      add_belongs_to breeze_request : BreezeRequest?, on_delete: :nullify
    end

    create table_for(BreezePipe) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add continued : Bool
      add_belongs_to breeze_request : BreezeRequest, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(BreezeRequest)
    drop table_for(BreezeResponse)
    drop table_for(BreezePipe)
    drop table_for(BreezeSqlStatement)
  end
end
