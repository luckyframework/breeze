module Breeze::ActionHelpers
  macro included
    after store_breeze

    private def store_breeze
      if Breeze.settings.enabled
        req = BreezeRequest::SaveOperation.create!(
          path: request.resource,
          method: request.method,
          action: self.class.name,
          status: response.status_code,
          session: JSON.parse(session.to_json),
          headers: JSON.parse(request.headers.to_h.to_json)
        )
        Lucky::Log.dexter.debug { {debug_at: Breeze::Requests::Show.url(req.id)} }
      end

      continue
    end
  end
end
