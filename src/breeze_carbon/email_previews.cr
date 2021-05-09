require "wordsmith"

# TODO: Move this in to Carbon directly
abstract class Carbon::EmailPreviews
  abstract def previews : Array(Carbon::Email)

  def self.find(key : String) : Carbon::Email
    email = self.new.previews.find do |carbon|
      carbon.class.name == key
    end

    email || raise "No Carbon::Email found with the key #{key}. Be sure to add it to your `previews` method"
  end
end
