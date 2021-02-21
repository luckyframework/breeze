class Breeze::MediumSidebar < BreezeComponent
  def render
    div class: "hidden md:flex md:flex-shrink-0" do
      div class: "flex flex-col w-64 border-r border-gray-200 bg-white" do
        div class: "h-0 flex-1 flex flex-col pt-5 pb-4 overflow-y-auto" do
          mount Breeze::SidebarLinks
        end
      end
    end
  end
end
