abstract class BreezeBaseModel < Avram::Model
  def self.database : Avram::Database.class
    Breeze.settings.database
  end
end
