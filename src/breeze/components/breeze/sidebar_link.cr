class Breeze::SidebarLink < BreezeComponent
  needs context : HTTP::Server::Context
  needs link_text : String
  needs link_to : String

  def render
    a link_text, href: link_to, class: link_styles
  end

  def link_styles
    extra_classes =
      if current_page?(context.request.path)
        link_active_class
      else
        link_inactive_class
      end
    "#{extra_classes} block px-3 py-2 mr-3 rounded-md text-base font-medium focus:outline-none focus:text-white focus:bg-gray-700"
  end

  def link_inactive_class
    "text-gray-300 hover:text-white hover:bg-gray-700"
  end

  def link_active_class
    "bg-teal-500 text-white"
  end
end
