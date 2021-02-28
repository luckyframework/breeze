require "pulsar"
require "avram"
require "lucky"
require "./charms/*"
require "./breeze/models/*"
require "./breeze/operations/*"
require "./breeze/queries/*"
require "./breeze/actions/mixins/*"

# Include Breeze in to all Actions once required
abstract class Lucky::Action
  include Breeze::ActionHelpers
end

require "./breeze/actions/breeze_action"
require "./breeze/actions/**"
require "./breeze/components/**"
require "./breeze/pages/**"

module Breeze
  VERSION = "0.1.0"

  Habitat.create do
    setting database : Avram::Database.class, example: "AppDatabase"
    setting enabled : Bool, example: "Lucky::Env.development?"
  end
end
