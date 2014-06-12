class MentorBio < ActiveRecord::Base
  belongs_to :user

  def dance_style=(styles)
    self[:dance_style] = styles.reject!{|s| s.blank?}
  end

  def talent_expertise=(expertise)
    self[:talent_expertise] = expertise.reject!{|s| s.blank?}
  end
end