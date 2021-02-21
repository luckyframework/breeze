class Breeze::SmallSidebar < BreezeComponent
  needs context : HTTP::Server::Context

  def render
    div class: "md:hidden", x_show: "sidebarOpen" do
      div "@click": "sidebarOpen = false", class: "fixed inset-0 z-30 transition-opacity ease-linear duration-300", "x-transition:enter-end": "opacity-100", "x-transition:enter-start": "opacity-0", "x-transition:leave-end": "opacity-0", "x-transition:leave-start": "opacity-100", x_show: "sidebarOpen" do
        div class: "absolute inset-0 bg-gray-600 opacity-75"
      end
      div class: "fixed inset-0 flex z-40" do
        div class: "flex-1 flex flex-col max-w-xs w-full bg-white transform ease-in-out duration-300 ", "x-transition:enter-end": "translate-x-0", "x-transition:enter-start": "-translate-x-full", "x-transition:leave-end": "-translate-x-full", "x-transition:leave-start": "translate-x-0", x_show: "sidebarOpen" do
          div class: "absolute top-0 right-0 -mr-14 p-1" do
            button "@click": "sidebarOpen = false", class: "flex items-center justify-center h-12 w-12 rounded-full focus:outline-none focus:bg-gray-600", x_show: "sidebarOpen" do
              tag "svg", class: "h-6 w-6 text-white", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
                tag "path", d: "M6 18L18 6M6 6l12 12", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
              end
            end
          end
          div class: "flex-1 h-0 pt-5 pb-4 overflow-y-auto" do
            mount Breeze::SidebarLinks, context: context
          end
        end
      end
    end
  end
end
