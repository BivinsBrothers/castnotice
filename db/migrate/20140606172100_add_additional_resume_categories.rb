class AddAdditionalResumeCategories < ActiveRecord::Migration
  def change
    %w(accents athletic_endeavors disabilities disability_assistive_devices
       ethnicities fluent_languages performance_skills ).each do |model|
      create_table model do |t|
        t.string :name
        t.timestamps
      end

      create_table "resume_#{model}" do |t|
        t.belongs_to :resume
        t.belongs_to model.singularize
        t.timestamps
      end
    end
  end
end
