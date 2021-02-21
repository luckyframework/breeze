abstract class BreezeComponent < Lucky::BaseComponent
  alias HtmlProc = Proc(IO::Memory) | Proc(Nil)
end
