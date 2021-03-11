class Breeze::NavbarLinks < BreezeComponent
  needs context : HTTP::Server::Context

  def render
    mount Breeze::NavbarLink(Breeze::Requests::Index), context: context, content: "Requests"
    mount Breeze::NavbarLink(Breeze::Queries::Index), context: context, content: "Queries"
  end
end
