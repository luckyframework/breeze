class Breeze::Badge < BreezeComponent
  needs req : BreezeRequest
  needs large : Bool = false

  def render
    span class: "#{styles.wrapper} inline-flex items-center rounded-md font-medium leading-5 bg-blue-100 tracking-wide text-blue-800" do
      text req.method
      mount RowArrow, "#{styles.arrow} text-blue-400 inline-block"
      span req.path, class: "font-bold"
    end
  end

  def styles
    large? ? LargeStyles.new : RegularStyles.new
  end

  struct RegularStyles
    def wrapper
      "px-2 py-1"
    end

    def arrow
      "h-4 w-4"
    end
  end

  struct LargeStyles
    def wrapper
      "px-3 py-2"
    end

    def arrow
      "h-5 w-5"
    end
  end
end
