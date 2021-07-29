# To create an extension you must extend this module
#
# Example:
# ```
# module BreezeCustom
#   extend Breeze::Extension
#
#   def self.navbar_link : Breeze::NavbarLink
#     Breeze::NavbarLink.new(link_text: "Custom", link_to: BreezeCustom::Index.path)
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
  def navbar_link(context : HTTP::Server::Context) : Breeze::NavbarLink
    {% raise "Breeze::Extension navbar_link no longer requires `context` to be passed in" %}
  end

  abstract def navbar_link : Breeze::NavbarLink
end
