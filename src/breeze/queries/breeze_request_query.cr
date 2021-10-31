class Breeze::BreezeRequestQuery < Breeze::BreezeRequest::BaseQuery
  include Breeze::Queries::Resetable

  # Pass in the string "last" to return the
  # most recent BreezeRequest. Or pass in the ID
  # of the specific BreezeRequest record you're
  # looking for
  def find_specific_or_last(id_or_last : String) : BreezeRequest
    if id_or_last == "last"
      created_at.asc_order.last
    else
      find(id_or_last)
    end
  end
end
