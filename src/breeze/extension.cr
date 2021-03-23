# To create an extension you must extend this module
#
# Example:
# ```
# module BreezeCustom
#   extend Breeze::Extension
#
#   def self.name : String
#     "Custom"
#   end
#
#   def self.entrypoint : Lucky::Action.class
#     BreezeCustom::Index
#   end
# end
# ```
#
# Projects that want to use this extension will need to register it
#
# ```
# Breeze.register BreezeCustom
# ```
#
module Breeze::Extension
  # The name of the extension
  # Will be used as the text in the link found in the navbar
  abstract def name : String

  # The entrypoint of the extension
  # Will be used as the href of the navbar link
  abstract def entrypoint : Lucky::Action.class
end
