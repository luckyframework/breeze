abstract class BreezeLayout
  include Lucky::HTMLPage

  abstract def content
  abstract def page_title : String

  def render
    html_doctype

    html lang: "en" do
      mount Breeze::LayoutHead, page_title: page_title, context: @context

      body do
        tailwind
      end
    end
  end

  def tailwind
    div "@keydown.window.escape": "sidebarOpen = false", class: "h-screen flex overflow-hidden bg-gray-100", x_data: "{ sidebarOpen: false }" do
      mount Breeze::SmallSidebar
      mount Breeze::MediumSidebar
      div class: "flex flex-col w-0 flex-1 overflow-hidden" do
        div class: "md:hidden pl-1 pt-1 sm:pl-3 sm:pt-3" do
          button "@click.stop": "sidebarOpen = true", class: "-ml-0.5 -mt-0.5 h-12 w-12 inline-flex items-center justify-center rounded-md text-gray-500 hover:text-gray-900 focus:outline-none focus:bg-gray-200 transition ease-in-out duration-150" do
            tag "svg", class: "h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
              tag "path", d: "M4 6h16M4 12h16M4 18h16", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
            end
          end
        end
        main class: "flex-1 relative z-0 overflow-y-auto pt-2 pb-6 focus:outline-none md:py-6", tabindex: "0", x_data: "", x_init: "$el.focus()" do
          div class: "max-w-7xl mx-auto px-4 sm:px-6 md:px-8" do
            h1 class: "ml-5 mb-1 text-2xl font-semibold text-gray-900" do
              render_if_defined(:breadcrumb_parent)
              text page_title
            end
          end
          div class: "max-w-7xl mx-auto px-4 sm:px-6 md:px-8" do
            div class: "py-4" do
              mount Breeze::FlashMessages, flash: @context.flash
              content
            end
          end
        end
      end
    end
  end
end
