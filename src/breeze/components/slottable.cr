module Breeze::Slottable
  macro has_one(name)
    property {{ name.id }} : Proc(Nil)?

    def {{ name.id }}(&block)
      @{{ name.id }} = block
    end
  end

  macro has_many(name)
    property {{ name.id }} = [] of Proc(Nil)

    def {{ name.id }}(&block)
      @{{ name.id }} << block
    end
  end
end
