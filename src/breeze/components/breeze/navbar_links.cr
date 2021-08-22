class Breeze::NavbarLinks < Breeze::BreezeComponent
  def render
    mount_link("Requests", to: Breeze::Requests::Index)
    mount_link("Queries", to: Breeze::Queries::Index)
    Breeze.extensions.each do |extension|
      mount_instance extension.navbar_link
    end
  end

  private def mount_link(link_text : String, to action : Lucky::Action.class)
    mount(Breeze::NavbarLink, link_text: link_text, link_to: action.path)
  end
end
