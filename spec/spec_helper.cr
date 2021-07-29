require "spec"
require "file_utils"
require "lucky_cli"
require "./support/**"

if ENV["BREEZE_TEST_LOCATION"]?.nil?
  ENV["BREEZE_TEST_LOCATION"] = Dir.current
end
