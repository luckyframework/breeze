class Breeze::DescriptionListRow < BreezeComponent
  needs key : String
  needs value : String

  def render
    div class: "mt-8 sm:mt-0 sm:grid sm:grid-cols-3 sm:gap-4 sm:border-t sm:border-gray-200 sm:px-6 sm:py-5" do
      dt class: "text-sm leading-5 font-medium text-gray-500" do
        text key
      end
      dd class: "mt-1 text-sm leading-5 text-gray-900 sm:mt-0 sm:col-span-2 overflow-scroll" do
        text value
      end
    end
  end
end
