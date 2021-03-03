module Breeze::ActionHelpers
  macro included
    before store_breeze_request
    after store_breeze_response

    Avram::Events::QueryEvent.subscribe do |event|
      unless event.query.includes?("breeze_") || event.query.includes?("information_schema")
        req = Fiber.current.breeze_request
        spawn do
          SaveBreezeSqlStatement.create!(
            breeze_request_id: req.try(&.id),
            statement: event.query,
            args: event.args,
            model: event.queryable
          )
        end
      end
    end
  end

  private def store_breeze_request
    if Breeze.settings.enabled
      req = SaveBreezeRequest.create!(
        path: request.resource,
        method: request.method,
        action: self.class.name,
        body: request.body.try(&.to_s),
        parsed_params: JSON.parse(params.to_h.to_json),
        session: JSON.parse(session.to_json),
        headers: JSON.parse(request.headers.to_h.to_json)
      )
      Lucky::Log.dexter.debug { {debug_at: Breeze::Requests::Show.url(req.id)} }
      Fiber.current.breeze_request = req
    end

    continue
  end

  private def store_breeze_response
    if Breeze.settings.enabled
      req = Fiber.current.breeze_request.not_nil!
      # TODO: can we run this in a spawn?
      SaveBreezeResponse.create!(
        breeze_request_id: req.id,
        status: response.status_code,
        session: JSON.parse(session.to_json),
        headers: JSON.parse(response.headers.to_h.to_json)
      )
    end

    continue
  end
end
