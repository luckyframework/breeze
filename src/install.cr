require "colorize"
require "../tasks/generators/*"

class Breeze::Install < LuckyTask::Task
  summary "Installs the required files for running Breeze"

  def call
    print_installation_message

    Breeze::ConfigGenerator.new.generate
  rescue e : Exception
    output.puts <<-MESSAGE.colorize(:red)
    Breeze installation failed:

    #{e.message}
    MESSAGE
  end

  private def print_installation_message
    output.puts ""
    output.puts installing_background
    output.puts installing_message.colorize.on_cyan.black
    output.puts installing_background
    output.puts ""
  end

  private def installing_background
    extra_space_for_emoji = 1
    (" " * (installing_message.size + extra_space_for_emoji)).colorize.on_cyan
  end

  private def installing_message
    "   💨 Installing Breeze!   "
  end
end
