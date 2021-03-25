# https://tailwindui.com/components/application-ui/data-display/description-lists#component-e1b5917b21bbe76a73a96c5ca876225f
class Breeze::DescriptionList < Breeze::BreezeComponent
  def render
    slots = Slots.new
    yield slots
    render_main_heading(slots.heading_title)
    render_list(slots.list)
  end

  def render_main_heading(heading_title)
    div class: "px-4 py-5 border-b border-gray-200 sm:px-6" do
      h3 class: "text-lg leading-6 font-medium text-gray-900" do
        heading_title.try(&.call)
      end
    end
  end

  def render_list(list)
    div class: "px-4 py-5 sm:p-0" do
      dl do
        list.try(&.call)
      end
    end
  end

  class Slots
    include Breeze::Slottable

    has_one :heading_title
    has_one :list
  end
end
