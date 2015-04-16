module ApplicationHelper
  require "ostruct"

  def us_states_select
    Country['US'].states.map do |abbr, names|
      [names["name"], abbr]
    end
  end

  def height_options
    36.upto(84).map do |inches|
      [%{#{inches / 12}'#{inches % 12}"}, inches]
    end
  end

  def grade_level_select
    k12 = (1..12).map do |n|
      [n.ordinalize, n]
    end
    college = ["College freshmen", "College sophomore", "College junior", "College senior"]
    k12 + college
  end

  def shirt_size_select
    %w[CS CM CL AS AM AL AXL AXXL AXXXL].map do |size|
      [I18n.t(size, scope: "helpers.label.shirt_size", default: size), size]
    end
  end

  def eye_color_select
    Resume::EYE_COLORS.map do |color|
      [I18n.t("helpers.label.resume.eye_colors.#{color}"), color]
    end
  end

  def hair_color_select
    Resume::HAIR_COLORS.map do |color|
      [I18n.t("helpers.label.resume.hair_colors.#{color}"), color]
    end
  end

  def hair_length_select
    Resume::HAIR_LENGTHS.map do |length|
      [I18n.t("helpers.label.resume.hair_lengths.#{length}"), length]
    end
  end

  def piercing_select
    Resume::PIERCINGS.map do |piercing|
      [I18n.t("helpers.label.resume.piercings.#{piercing}"), piercing]
    end
  end

  def tatoo_select
    Resume::TATTOOS.map do |tattoo|
      [I18n.t("helpers.label.resume.tattoos.#{tattoo}"), tattoo]
    end
  end

  def citizen_select
    Resume::CITIZENS.map do |citizen|
      [I18n.t("helpers.label.resume.citizens.#{citizen}"), citizen]
    end
  end

  def agent_type_select
    Resume::AGENT_TYPES.map do |agent_type|
      [I18n.t("helpers.label.resume.agent_types.#{agent_type}"), agent_type]
    end
  end

  def expertise_checkboxes
    MentorBio::TALENT_EXPERTISES.map do |expertise|
      [I18n.t("helpers.label.mentor_bio.expertises.#{expertise}"), expertise]
    end
  end

  def dance_style_checkboxes
    MentorBio::DANCE_STYLES.map do |style|
      [I18n.t("helpers.label.mentor_bio.dance_styles.#{style}"), style]
    end
  end

  def type_select
    Critique::TYPES.map do |type|
      [I18n.t("helpers.label.critique.types.#{type}"), type]
    end
  end

  def education_type_select
    School::EDUCATION_TYPES.map do |education_type|
      [I18n.t("helpers.label.school.education_types.#{education_type}"), education_type]
    end
  end

  def education_type_name(education_type)
    I18n.t("helpers.label.school.education_types.#{education_type}")
  end

  def for_select_by_model(klass)
    klass.all.map { |r| [r.name, r.id] }
  end

  def sentence_for_category_collection(category)
    category.map(&:name).to_sentence
  end

  def message_toolbar
    if (unread_count = current_user.unread_messages.count) > 0
      link_to "You have #{unread_count} new #{'message'.pluralize(unread_count)}", conversations_path
    else
      link_to "Messages", conversations_path
    end
  end
end

