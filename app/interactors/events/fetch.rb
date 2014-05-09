module Events
  class Fetch
    include Interactor::Organizer

    def setup
      if context[:date]
        context[:start_date] = DateTime.parse(date[:start])
        context[:end_date]   = DateTime.parse(date[:end])
      else
        context[:start_date] = DateTime.now.in_time_zone("UTC").beginning_of_month
        context[:end_date]   = DateTime.now.in_time_zone("UTC").end_of_month
      end
    end

    organize [
      SetQueryDateRange,
      QueryEvents
    ]
  end
end
