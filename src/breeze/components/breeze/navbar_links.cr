class Breeze::NavbarLinks < Breeze::BreezeComponent
  needs context : HTTP::Server::Context

  def render
    mount_link("Requests", to: Breeze::Requests::Index)
    mount_link("Queries", to: Breeze::Queries::Index)
    Breeze.extensions.each do |extension|
      extension.navbar_link(context)
        .view(view)
        .render
    end
  end

  private def mount_link(link_text : String, to action : Lucky::Action.class)
    mount(Breeze::NavbarLink, context: context, link_text: link_text, link_to: action.path)
  end
end
