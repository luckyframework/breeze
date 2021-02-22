require "avram"
require "lucky"
require "./breeze/models/*"
require "./breeze/operations/*"
require "./breeze/queries/*"
require "./breeze/actions/mixins/*"
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
