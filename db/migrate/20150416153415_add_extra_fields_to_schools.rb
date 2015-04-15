class AddExtraFieldsToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :acting, :text
    add_column :schools, :dance, :text
    add_column :schools, :voice, :text
    add_column :schools, :stage_combat, :text
  end
end
