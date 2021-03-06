require "carbon"
require "./email_previews"

require "./actions/**"
require "./pages/**"

module Breeze
  Habitat.extend do
    setting email_previews : Carbon::EmailPreviews.class, example: "Emails::Previews"
  end
end

Breeze::SidebarLinks.settings.links << ->(breeze : Breeze::SidebarLinks) {
  breeze.mount(Breeze::SidebarLink, context: breeze.context, link_text: "Emails", link_to: Breeze::Emails::Index.path)
}
