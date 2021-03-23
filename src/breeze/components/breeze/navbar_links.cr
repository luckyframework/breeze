class Breeze::NavbarLinks < Breeze::BreezeComponent
  needs context : HTTP::Server::Context

  Habitat.create do
    setting links : Array(Proc(Breeze::NavbarLinks, Nil)) = [
      ->(navbar : Breeze::NavbarLinks) {
        navbar.mount_link("Requests", to: Breeze::Requests::Index)
      },
      ->(navbar : Breeze::NavbarLinks) {
        navbar.mount_link("Queries", to: Breeze::Queries::Index)
      },
    ]
  end

  def render
    settings.links.each do |component|
      component.call(self)
    end
  end

  def mount_link(link_text : String, to action : Lucky::Action.class)
    mount(Breeze::NavbarLink, context: context, link_text: link_text, link_to: action.path)
  end
end
