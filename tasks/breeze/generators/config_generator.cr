require "ecr"
require "file_utils"

class Breeze::ConfigGenerator
  ECR.def_to_s "#{__DIR__}/templates/breeze_config.ecr"

  getter name : String

  def initialize
    @name = "breeze"
  end

  def generate
    ensure_unique!
    File.write(file_path, contents)
    STDOUT.puts "Created #{name.colorize(:green)} config in .#{relative_file_path.colorize(:green)}"
  end

  private def ensure_unique!
    d = Dir.new(Dir.current + "/config")
    d.each_child { |x|
      if x == "#{name}.cr"
        raise <<-ERROR
          Breeze configuration file already exists in #{"config/#{x}".colorize.red}

          If you're already using this configuration, you can update any changes made:

          #{to_s}
        ERROR
      end
    }
  end

  private def file_path
    Dir.current + relative_file_path
  end

  private def relative_file_path
    "/config/#{name}.cr"
  end

  private def contents
    to_s
  end
end
