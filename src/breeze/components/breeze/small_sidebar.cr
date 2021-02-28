class Breeze::SmallSidebar < BreezeComponent
  needs context : HTTP::Server::Context

  def render
    div x_show: "sidebarOpen", class: "border-b border-gray-700 md:hidden" do
      div class: "px-2 py-3 sm:px-3" do
        mount Breeze::SidebarLinks, context: @context
      end
    end
  end
end
