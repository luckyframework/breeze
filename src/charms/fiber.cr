# https://crystal-lang.org/api/latest/Fiber.html
class Fiber
  # This is stored in the Fiber so other stuff can access it.
  # For example, we can associate queries and pipes with the request
  property breeze_request : Breeze::BreezeRequest?
  property breeze_request_start : Time::Span?
end
