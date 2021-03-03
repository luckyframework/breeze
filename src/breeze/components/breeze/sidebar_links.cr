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
    # settings.links.each do |link_title, link_action|
    #   mount Breeze::SidebarLink(Breeze::Queries::Index), context: context, content: "Queries"
    # end
  end
end
