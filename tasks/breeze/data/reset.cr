require "colorize"

class Breeze::Data::Reset < LuckyCli::Task
  summary "Deletes all of the Breeze data"

  def call
    table_names = [] of String
    {% for type in Breeze::Queries::Resetable.includers %}
      table_names << {{ type }}.new.table_name.to_s
    {% end %}

    table_names = table_names.join(", ")
    statement = <<-SQL
    TRUNCATE TABLE #{table_names} RESTART IDENTITY CASCADE;
    SQL

    output.puts "Truncating tables #{table_names.colorize(:green)}"

    Breeze.settings.database.exec statement
    puts "done."
  end
end
