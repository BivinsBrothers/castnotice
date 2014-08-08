class AllowLongWindedeventCastingDirectors < ActiveRecord::Migration
  def change
    change_column :events, :casting_director, :text
  end
end
