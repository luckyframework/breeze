class RowArrow < BreezeComponent
  needs html_class : String = "h-5 w-5 text-gray-400"

  def render
    tag "svg", class: html_class, fill: "currentColor", viewBox: "0 0 20 20" do
      tag "path",
        clip_rule: "evenodd",
        d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z",
        fill_rule: "evenodd"
    end
  end
end
