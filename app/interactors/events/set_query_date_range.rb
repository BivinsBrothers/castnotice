module Events
  class SetQueryDateRange
    include Interactor

    def perform
      if end_date < 60.days.ago
        context[:query_date_range] = nil
      elsif start_date < 60.days.ago && end_date > 60.days.ago
        context[:query_date_range] = 60.days.ago..end_date
      else
        context[:query_date_range] = start_date..end_date
      end
    end
  end
end
