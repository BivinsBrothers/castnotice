module Events
  class QueryEvents
    include Interactor

    def perform
      context[:events] = Event.where(audition_date: (query_date_range)).order("audition_date ASC")
    end
  end
end
