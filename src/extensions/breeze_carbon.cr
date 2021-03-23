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

  def self.name : String
    "Emails"
  end

  def self.entrypoint : Lucky::Action.class
    BreezeCarbon::Emails::Index
  end
end
