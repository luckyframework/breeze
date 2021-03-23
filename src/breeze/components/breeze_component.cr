abstract class Breeze::BreezeComponent < Lucky::BaseComponent
  include Lucky::UrlHelpers
  alias HtmlProc = Proc(IO::Memory) | Proc(Nil)

  def mount(component : Lucky::BaseComponent, *args, **named_args) : Nil
    print_component_comment(component) do
      component.view(view).render
    end
  end

  def mount(component : Lucky::BaseComponent, *args, **named_args) : Nil
    print_component_comment(component) do
      component.view(view).render do |*yield_args|
        yield *yield_args
      end
    end
  end

  private def print_component_comment(component : Lucky::BaseComponent) : Nil
    print_component_comment(component.class) do
      yield
    end
  end
end
