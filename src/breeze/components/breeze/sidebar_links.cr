class Breeze::SidebarLinks < BreezeComponent
  needs context : HTTP::Server::Context

  Habitat.create do
    setting links : Array(Proc(Breeze::SidebarLinks, Nil)) = [
      ->(breeze : Breeze::SidebarLinks) {
        breeze.mount(Breeze::SidebarLink, context: breeze.context, link_text: "Requests", link_to: Breeze::Requests::Index)
      },
      ->(breeze : Breeze::SidebarLinks) {
        breeze.mount(Breeze::SidebarLink, context: breeze.context, link_text: "Queries", link_to: Breeze::Queries::Index)
      },
    ]
  end

  def render
    settings.links.each do |component|
      component.call(self)
    end
  end

  private def sidebar_link_css : String
    "mb-1 group flex items-center px-2 py-2 text-sm leading-5 font-medium text-gray-600 rounded-md hover:text-gray-900 hover:bg-gray-50 focus:outline-none focus:bg-gray-100 transition ease-in-out duration-150"
  end

  private def active_link_css_for_route(route : Lucky::Action.class) : String
    if route.path == context.request.path
      "bg-green-400 hover:text-white hover:bg-green-500"
    else
      ""
    end
  end
end
