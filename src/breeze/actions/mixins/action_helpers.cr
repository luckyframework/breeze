module Breeze::ActionHelpers
  Habitat.create do
    setting skip_pipes_if : Proc(HTTP::Server::Context, Bool)?
  end

  macro included
    before store_breeze_request
    after store_breeze_response

    Avram::Events::QueryEvent.subscribe do |event, duration|
      next unless Breeze.settings.enabled
      # TODO: move this to a config setting
      next if event.query.includes?("breeze_") || event.query.includes?("information_schema")

      req = Fiber.current.breeze_request
      spawn do
        SaveBreezeSqlStatement.create!(
          breeze_request_id: req.try(&.id),
          statement: event.query,
          args: event.args,
          model: event.queryable,
          elapsed_text: duration.to_elapsed_text
        )
      end
    end
  end

  private def store_breeze_request
    if allow_breeze(context)
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
    if allow_breeze(context)
      req = Fiber.current.breeze_request.not_nil!
      spawn do
        SaveBreezeResponse.create!(
          breeze_request_id: req.id,
          status: response.status_code,
          session: JSON.parse(session.to_json),
          headers: JSON.parse(response.headers.to_h.to_json)
        )
      end
    end

    continue
  end

  private def allow_breeze(context : HTTP::Server::Context)
    should_skip = settings.skip_pipes_if.try(&.call(context))
    Breeze.settings.enabled && !should_skip
  end
end
