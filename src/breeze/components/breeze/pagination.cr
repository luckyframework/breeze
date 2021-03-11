class Breeze::Pagination < BreezeComponent
  needs pages : Lucky::Paginator

  def render
    css = "bg-gray-50 px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6"
    div aria_label: "pagination", role: "navigation", class: css do
      unless pages.one_page?
        next_and_previous_links_for_small_screens
      end
      div class: "sm:flex-1 sm:flex sm:items-center sm:justify-between" do
        page_metadata

        unless pages.one_page?
          div class: "cursor-pointer hidden sm:inline-block" do
            span class: "relative z-0 inline-flex shadow-sm" do
              prev_arrow_link
              page_links
              next_arrow_link
            end
          end
        end
      end
    end
  end

  def page_links
    @pages.series(begin: 2, left_of_current: 1, right_of_current: 1, end: 2).each do |item|
      render_page_item(item)
    end
  end

  def render_page_item(page : Lucky::Paginator::Page)
    a page.number, href: page.path, class: button_styles
  end

  def render_page_item(page : Lucky::Paginator::CurrentPage)
    span page.number,
      class: "#{button_styles} cursor-default bg-blue-100 hover:bg-blue-100 text-blue-800"
  end

  def button_styles
    <<-TEXT.lines.join(" ")
    -ml-px relative inline-flex items-center px-4 py-2 border border-gray-300
    bg-white text-sm leading-5 font-medium text-gray-700 hover:text-gray-800
    hover:bg-gray-100 focus:z-10 focus:outline-none focus:border-blue-300
    focus:shadow-outline-blue active:bg-gray-100 active:text-gray-700
    transition ease-in-out duration-150
    TEXT
  end

  def render_page_item(gap : Lucky::Paginator::Gap)
    span "...", class: <<-TEXT.lines.join(" ")
      cursor-default -ml-px relative inline-flex items-center px-4 py-2 border
      border-gray-300 bg-white text-sm leading-5 font-medium text-gray-700
      TEXT
  end

  def prev_arrow_link
    a href: pages.path_to_previous || "#", class: "-mr-px px-4 rounded-l-md #{button_styles}" do
      tag "svg", class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20" do
        tag "path",
          clip_rule: "evenodd",
          d: "M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z",
          fill_rule: "evenodd"
      end
    end
  end

  def next_arrow_link
    a href: pages.path_to_next || "#", class: "-ml-px px-4 rounded-r-md #{button_styles}" do
      tag "svg", class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20" do
        tag "path", clip_rule: "evenodd", d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z", fill_rule: "evenodd"
      end
    end
  end

  def next_and_previous_links_for_small_screens
    div class: "flex-1 flex justify-between sm:hidden" do
      a "Previous",
        href: pages.path_to_previous || "#",
        class: <<-TEXT.lines.join(" ")
          relative inline-flex items-center px-4 py-2 border border-gray-300
          text-sm leading-5 font-medium rounded-md text-gray-700 bg-white
          hover:text-gray-500 focus:outline-none focus:shadow-outline-blue
          focus:border-blue-300 active:bg-gray-100 active:text-gray-700
          transition ease-in-out duration-150
          TEXT
      a "Next",
        href: pages.path_to_next || "#",
        class: <<-TEXT.lines.join(" ")
          ml-3 relative inline-flex items-center px-4 py-2 border
          border-gray-300 text-sm leading-5 font-medium rounded-md
          text-gray-700 bg-white hover:text-gray-500 focus:outline-none
          focus:shadow-outline-blue focus:border-blue-300 active:bg-gray-100
          active:text-gray-700 transition ease-in-out duration-150
          TEXT
    end
  end

  def page_metadata
    div class: "#{"hidden sm:flex" unless pages.one_page?}" do
      para class: "text-sm leading-5 text-gray-700" do
        range = pages.item_range
        text " Showing "
        span range.begin, class: "font-medium"
        text " to "
        span range.end, class: "font-medium"
        text " of "
        span pages.item_count, class: "font-medium"
        text " results "
      end
    end
  end
end
