abstract class BreezeAction < Lucky::Action
  include Lucky::ProtectFromForgery
  include Lucky::Paginator::BackendHelpers
  accepted_formats [:html, :json], default: :html

  route_prefix "/breeze"

  before ensure_breeze_enabled

  private def ensure_breeze_enabled
    if Breeze.settings.enabled
      continue
    else
      plain_text "This action is not permitted", status: :unauthorized
    end
  end
end
