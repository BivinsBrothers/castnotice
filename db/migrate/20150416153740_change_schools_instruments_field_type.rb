class ChangeSchoolsInstrumentsFieldType < ActiveRecord::Migration
  def up
    change_column :schools, :instruments, :text
  end

  def down
    change_column :schools, :instruments, :string
  end
end
