# TODO: Move this in to Carbon directly
# This patch allows us to see what the class names of
# all the carbon emails are
abstract class Carbon::Email
  def self.email_classes
    {{ Carbon::Email.all_subclasses.select(&.abstract?.!) }}
  end
end
