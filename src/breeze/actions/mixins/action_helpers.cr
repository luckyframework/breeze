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
      spawn(name: "Create Breeze::SaveBreezeSqlStatement") do
        Breeze::SaveBreezeSqlStatement.create!(
          breeze_request_id: req.try(&.id),
          statement: event.query,
          args: event.args,
          model: event.queryable,
          elapsed_text: duration.to_elapsed_text
        )
      end
    end

    Lucky::Events::PipeEvent.subscribe do |event|
      next unless Breeze.settings.enabled
      # TODO: move this to a config setting
      next if event.name.starts_with?("store_breeze_")

      request = Fiber.current.breeze_request
      spawn(name: "Create Breeze::SaveBreezePipe") do
        if req = request
          Breeze::SaveBreezePipe.create!(
            breeze_request_id: req.id,
            name: event.name,
            continued: event.continued,
            position: event.position.to_s
          )
        end
      end
    end
  end

  private def store_breeze_request
    if allow_breeze(context)
      if multipart?
        request_body = build_request_body_with_file(context)
        # If we don't rewind here, the request fails when it gets to
        # the action.
        request.body.try(&.rewind)
      else
        request_body = request.body.try(&.to_s)
      end

      req = Breeze::SaveBreezeRequest.create!(
        path: request.resource,
        method: request.method,
        action: self.class.name,
        body: request_body,
        parsed_params: JSON.parse(params.to_h.to_json),
        session: JSON.parse(session.to_json),
        headers: JSON.parse(request.headers.to_h.to_json)
      )
      Lucky::Log.dexter.debug { {debug_at: Breeze::Requests::Show.url(req.id)} }
      Fiber.current.breeze_request = req
      Fiber.current.breeze_request_start = Time.monotonic
    end

    continue
  end

  private def store_breeze_response
    if allow_breeze(context)
      duration = Time.monotonic - Fiber.current.breeze_request_start.not_nil!
      req = Fiber.current.breeze_request.not_nil!
      spawn(name: "Create Breeze::SaveBreezeResponse") do
        Breeze::SaveBreezeResponse.create!(
          breeze_request_id: req.id,
          status: response.status_code,
          elapsed_text: duration.to_elapsed_text,
          session: JSON.parse(session.to_json),
          headers: JSON.parse(response.headers.to_h.to_json)
        )
      end
    end

    continue
  end

  private def allow_breeze(context : HTTP::Server::Context)
    should_skip = Breeze::ActionHelpers.settings.skip_pipes_if.try(&.call(context))
    Breeze.settings.enabled && !should_skip
  end

  # This method re-builds the `request.body` output, and replaces file uploads
  # with a placeholder. This is because binary files will be too large, and contain
  # invalid string characters to be stored in the database.
  private def build_request_body_with_file(context : HTTP::Server::Context) : String
    content_type = context.request.headers["Content-Type"]
    index = content_type.rindex("boundary=").try(&.+(9)) || 0
    boundary = content_type[index, content_type.size]

    String.build do |str|
      HTTP::FormData.parse(context.request) do |part|
        disposition = part.headers["Content-Disposition"]

        str << "#{boundary} Content-Disposition: #{disposition} "

        if part.filename
          str << %{<#Lucky::UploadedFile @filename="#{part.filename}">}
        else
          str << part.body.gets_to_end
        end
      end
    end
  end
end
