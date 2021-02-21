class Breeze::Badge < BreezeComponent
  needs req : BreezeRequest

  def render
    span class: "inline-flex items-center px-2 py-0.5 rounded-md text-sm font-medium leading-5 bg-blue-100 tracking-wide text-blue-800" do
      text req.method
      mount RowArrow, html_class: "text-blue-400 h-4 w-4 inline-block"
      text req.path
    end
  end
end
