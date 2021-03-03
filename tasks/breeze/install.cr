require "colorize"
require "./generators/*"

class Breeze::Install < LuckyCli::Task
  summary "Installs the required files for running Breeze"

  def call
    print_installation_message

    Breeze::ConfigGenerator.new.generate
  rescue e : Exception
    STDOUT.puts <<-MESSAGE.colorize(:red)
    Breeze installation failed:

    #{e.message}
    MESSAGE
  end

  private def print_installation_message
    STDOUT.puts ""
    STDOUT.puts installing_background
    STDOUT.puts installing_message.colorize.on_cyan.black
    STDOUT.puts installing_background
    STDOUT.puts ""
  end

  private def installing_background
    extra_space_for_emoji = 1
    (" " * (installing_message.size + extra_space_for_emoji)).colorize.on_cyan
  end

  private def installing_message
    "   💨 Installing Breeze!   "
  end
end
