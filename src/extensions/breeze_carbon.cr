require "carbon"
require "../breeze"
require "../breeze_carbon/email_previews"
require "../breeze_carbon/actions/**"
require "../breeze_carbon/pages/**"

module BreezeCarbon
  Habitat.create do
    setting email_previews : Carbon::EmailPreviews.class, example: "Emails::Previews"
  end
end

Breeze::NavbarLinks.settings.links << ->(navbar : Breeze::NavbarLinks) {
  navbar.mount_link("Emails", to: BreezeCarbon::Emails::Index)
}
