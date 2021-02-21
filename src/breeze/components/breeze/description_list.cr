# https://tailwindui.com/components/application-ui/data-display/description-lists#component-e1b5917b21bbe76a73a96c5ca876225f
class Breeze::DescriptionList < BreezeComponent
  needs heading_title : HtmlProc
  needs heading_subtitle : HtmlProc?
  needs list : HtmlProc

  def render
    mount Breeze::Panel do
      render_main_heading
      render_list
    end
  end

  def render_main_heading
    div class: "px-4 py-5 border-b border-gray-200 sm:px-6" do
      h3 class: "text-lg leading-6 font-medium text-gray-900" do
        heading_title.call
      end
      div class: "mt-2" do
        heading_subtitle.try(&.call)
      end
    end
  end

  def render_list
    div class: "px-4 py-5 sm:p-0" do
      dl do
        list.call
      end
    end
  end
end
