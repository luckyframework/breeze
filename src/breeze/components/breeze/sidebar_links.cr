class Breeze::SidebarLinks < BreezeComponent
  needs context : HTTP::Server::Context

  def render
    nav class: "mt-5 flex-1 px-2 bg-white" do
      link to: Breeze::Requests::Index, class: "#{sidebar_link_css} #{active_link_css_for_route(Breeze::Requests::Index)}" do
        tag "svg", class: "mr-3 h-6 w-6 text-green-200 group-hover:text-white group-focus:text-gray-600 transition ease-in-out duration-150", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
          tag "path", d: "M3 12l9-9 9 9M5 10v10a1 1 0 001 1h3a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1h3a1 1 0 001-1V10M9 21h6", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
        end
        text " Requests "
      end
      link to: Breeze::Emails::Index, class: "#{sidebar_link_css} #{active_link_css_for_route(Breeze::Emails::Index)}" do
        tag "svg", class: "mr-3 h-6 w-6 text-gray-400 group-hover:text-gray-500 group-focus:text-gray-500 transition ease-in-out duration-150", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
          tag "path", d: "M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
        end
        text " Emails "
      end
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
