struct Time::Span
  # Returns the total elapsed time as a printable String
  # limited to minutes as this will be called mainly on
  # Pulsar::TimedEvent durations
  def to_elapsed_text : String
    minutes = total_minutes
    return "#{minutes.round(2)}m" if minutes >= 1

    seconds = total_seconds
    return "#{seconds.round(2)}s" if seconds >= 1

    millis = total_milliseconds
    return "#{millis.round(2)}ms" if millis >= 1

    "#{(millis * 1000).round(2)}µs"
  end
end
