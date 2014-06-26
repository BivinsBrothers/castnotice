class ChangeCompanyPhoneToStringOnMentorBios < ActiveRecord::Migration
  class MentorBio < ActiveRecord::Base
  end

  def up
    rename_column :mentor_bios, :company_phone, :int_company_phone
    add_column :mentor_bios, :company_phone, :string
    MentorBio.reset_column_information

    MentorBio.all.each do |mentor|
      mentor.company_phone = mentor.int_company_phone.to_s
      mentor.save
    end

  end

  def down
    remove_column :mentor_bios, :company_phone
    rename_column :mentor_bios, :int_company_phone, :company_phone
  end
end
