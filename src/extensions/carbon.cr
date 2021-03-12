require "carbon"
require "./email_previews"

require "./actions/**"
require "./pages/**"

module Breeze
  Habitat.extend do
    setting email_previews : Carbon::EmailPreviews.class, example: "Emails::Previews"
  end
end

Breeze::NavbarLinks.settings.links << ->(navbar : Breeze::NavbarLinks) {
  navbar.mount_link(link_text: "Emails", link_to: Breeze::Emails::Index.path)
}
