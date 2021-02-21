require "ecr"
require "file_utils"
require "lucky_cli"

class Breeze::MigrationGenerator
  ECR.def_to_s "#{__DIR__}/templates/breeze_requests_migration.ecr"

  getter :name
  @_version : String?

  def initialize(@name : String)
  end

  def generate
    ensure_unique!
    File.write(file_path, contents)
    STDOUT.puts "Created #{migration_class_name.colorize(:green)} in .#{relative_file_path.colorize(:green)}"
  end

  private def ensure_unique!
    d = Dir.new(Dir.current + "/db/migrations")
    d.each_child { |x|
      if x.starts_with?(/[0-9]{14}_#{name.underscore}.cr/)
        raise <<-ERROR
          Migration name must be unique
          Migration name: #{name.underscore}.cr already exists as: #{x}.
        ERROR
      end
    }
  end

  private def migration_class_name
    "#{name}::V#{version}"
  end

  private def make_migrations_folder_if_missing
    FileUtils.mkdir_p Dir.current + "/db/migrations"
  end

  private def file_path
    Dir.current + relative_file_path
  end

  private def relative_file_path
    "/db/migrations/#{version}_#{name.underscore}.cr"
  end

  private def version
    @_version ||= Time.utc.to_s("%Y%m%d%H%M%S")
  end

  private def contents
    to_s
  end
end
