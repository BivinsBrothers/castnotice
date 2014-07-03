class MentorBio < ActiveRecord::Base
  TALENT_EXPERTISES = %w( plays musicals television film dance modeling )
  DANCE_STYLES = %w( ballet jazz lyrical_contemporary modern tap hip_hop clog )

  belongs_to :user

  validate :validate_dance_style
  validate :validate_talent_expertise

  def dance_style=(styles)
    self[:dance_style] = styles.reject!{|s| s.blank?}
  end

  def talent_expertise=(expertise)
    self[:talent_expertise] = expertise.reject!{|s| s.blank?}
  end

  private

  def validate_talent_expertise
    talent_expertise.each do |expertise|
      unless TALENT_EXPERTISES.include?(expertise)
        errors.add(:talent_expertse, "is not a valid talent expertise")
      end
    end
  end

  def validate_dance_style
    dance_style.each do |style|
      unless DANCE_STYLES.include?(style)
        errors.add(:talent_expertse, "is not a valid dance style")
      end
    end
  end
end
