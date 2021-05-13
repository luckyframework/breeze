require "lucky_task"
require "../../tasks/breeze/install"

Breeze::Install.new.print_help_or_call(ARGV)
