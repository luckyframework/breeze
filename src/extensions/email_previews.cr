# TODO: Move this in to Carbon directly
abstract class Carbon::EmailPreviews
  alias EmailLookup = Hash(String, Carbon::Email)

  abstract def previews : EmailLookup

  def self.find(key : String) : Carbon::Email
    self.new.previews[key]? || raise "No Carbon::Email found with the key #{key}. Be sure to add it to your `previews` method"
  end
end
