class Breeze::Panel < Breeze::BreezeComponent
  def render(&)
    div class: "mb-12 bg-white rounded-lg shadow-lg overflow-hidden" do
      yield
    end
  end
end
