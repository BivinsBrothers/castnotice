require "spec_helper"

def event_hash(event)
  {
     id: event.id,
     name: event.name,
     project_type: event.project_type,
     region: event.region,
     performer_type: event.performer_type,
     character: event.character,
     pay: event.pay,
     union: event.union,
     director: event.director,
     story: event.story,
     description: event.description,
     audition: event.audition,
     audition_date: event.audition_date.strftime("%Y-%m-%d"),
     start_date: event.start_date.strftime("%m-%d-%y"),
     end_date: event.end_date.strftime("%m-%d-%y"),
     paid: event.paid,
     location: event.location,
     casting_director: event.casting_director,
     writers: event.writers,
     producers: event.producers
  }
end

def limited_event_hash(event)
  {
     name: event.name,
     project_type: event.project_type,
     region: event.region,
     performer_type: event.performer_type,
     audition_date: event.audition_date.strftime("%Y-%m-%d"),
     paid: event.paid
  }
end

describe "Calendar API" do
  describe "GET /events" do
    context "when a member" do
      before do
        Timecop.freeze(Date.parse("2014-04-17"))

        user = create(:user)
        login_as user
      end

      after do
        Timecop.return
      end

      let!(:may_event) { create(:event, audition_date: 1.month.from_now) }
      let!(:april_event1) { create(:event, audition_date: 2.days.from_now) }
      let!(:april_event2) { create(:event, audition_date: 1.day.from_now) }

      context "when given a date range" do
        it "returns events within date range" do
          get events_path, {date: {start: "2014-05-01", end: "2014-05-30" }}

          expect(response.status).to eq(200)
          expect(response.body).to eq({
            "events" => [event_hash(may_event)],
            "meta" => {member: true, admin: false}
          }.to_json)
        end
      end

      context "when not given a date range" do
        it "returns full event json ordered by audition date for the current month" do
          get events_path

          expect(response.status).to eq(200)
          expect(response.body).to eq({
            "events" => [event_hash(april_event2), event_hash(april_event1)],
            "meta" => {member: true, admin: false}
          }.to_json)
        end
      end
    end

    context "when not a member" do
      before do
        Timecop.freeze(Date.parse("2014-04-17"))
      end

      after do
        Timecop.return
      end

      it "returns limited json when not a member" do
        event = create(:event, audition_date: 2.days.from_now)

        get events_path

        expect(response.status).to eq(200)
        expect(response.body).to eq({
          "events" => [limited_event_hash(event)],
          "meta" => {member: false, admin: false}
        }.to_json)
      end
    end
  end
end