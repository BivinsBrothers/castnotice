class CreateEventAuditionDates < ActiveRecord::Migration
  def change
    create_table :event_audition_dates do |t|
      t.integer :event_id
      t.date :audition_date

      t.timestamps
    end
  end
end
