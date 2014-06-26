class ChangeCompanyPhoneToStringOnMentorBios < ActiveRecord::Migration
  class MentorBio < ActiveRecord::Base
  end

  def up
    add_column :mentor_bios, :new_phone, :string

    MentorBio.all.each do |mentor|
      mentor.new_phone = mentor.company_phone.to_s
    end

  end

  def down
    remove_column :mentor_bios, :new_phone
  end
end
