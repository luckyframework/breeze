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
    if Lucky::HTMLPage.settings.render_component_comments
      raw "<!-- BEGIN: #{component.class.name} #{component.class.file_location} -->"
      yield
      raw "<!-- END: #{component.class.name} -->"
    else
      yield
    end
  end
end
