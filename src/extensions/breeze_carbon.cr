require "carbon"
require "../breeze"
require "../breeze_carbon/email_previews"
require "../breeze_carbon/actions/**"
require "../breeze_carbon/pages/**"

module BreezeCarbon
  extend Breeze::Extension

  Habitat.create do
    setting email_previews : Carbon::EmailPreviews.class, example: "Emails::Previews"
  end

  def self.navbar_link : Breeze::NavbarLink
    Breeze::NavbarLink.new(
      link_text: "Emails",
      link_to: BreezeCarbon::Emails::Index.path
    )
  end
end
