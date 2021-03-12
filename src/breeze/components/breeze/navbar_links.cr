class Breeze::NavbarLinks < BreezeComponent
  needs context : HTTP::Server::Context

  Habitat.create do
    setting links : Array(Proc(Breeze::NavbarLinks, Nil)) = [
      ->(navbar : Breeze::NavbarLinks) {
        navbar.mount_link(link_text: "Requests", link_to: Breeze::Requests::Index.path)
      },
      ->(navbar : Breeze::NavbarLinks) {
        navbar.mount_link(link_text: "Queries", link_to: Breeze::Queries::Index.path)
      },
    ]
  end

  def render
    settings.links.each do |component|
      component.call(self)
    end
  end

  def mount_link(link_text : String, link_to : String)
    mount(Breeze::NavbarLink, context: context, link_text: link_text, link_to: link_to)
  end
end
