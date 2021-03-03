class Breeze::SidebarLinks < BreezeComponent
  needs context : HTTP::Server::Context

  # NOTE: https://github.com/luckyframework/lucky/issues/1243
  # Habitat.create do
  #   setting links : Hash(String, BreezeAction.class) = {
  #     "Requests" => Breeze::Requests::Index,
  #     "Queries"  => Breeze::Queries::Index,
  #   }
  # end

  def render
    mount Breeze::SidebarLink(Breeze::Requests::Index), context: context, content: "Requests"
    mount Breeze::SidebarLink(Breeze::Queries::Index), context: context, content: "Queries"
    mount Breeze::SidebarLink(Breeze::Emails::Index), context: context, content: "Emails"
    # settings.links.each do |link_title, link_action|
    #   mount Breeze::SidebarLink(Breeze::Queries::Index), context: context, content: "Queries"
    # end
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
