class Breeze::NavbarLinks < BreezeComponent
  needs context : HTTP::Server::Context

  Habitat.create do
    setting links : Array(Proc(Breeze::NavbarLinks, Nil)) = [
      ->(breeze : Breeze::NavbarLinks) {
        breeze.mount(Breeze::NavbarLink, context: breeze.context, link_text: "Requests", link_to: Breeze::Requests::Index.path)
      },
      ->(breeze : Breeze::NavbarLinks) {
        breeze.mount(Breeze::NavbarLink, context: breeze.context, link_text: "Queries", link_to: Breeze::Queries::Index.path)
      },
    ]
  end

  def render
    settings.links.each do |component|
      component.call(self)
    end
  end
end
