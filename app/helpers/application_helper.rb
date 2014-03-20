module ApplicationHelper
  require "ostruct"

  def us_states_select
    Country['US'].states.map do |abbr, names|
      [names["name"], abbr]
    end
  end

  def height_options
    heights = Hash.new

    for n in 48..84
      feet = (n/12).floor
      inches = n % 12
      heights[n] = "#{feet}'#{inches}''"
    end

    return heights.to_a.sort.map { |h| h.reverse }
  end

  def eye_color_select
    [
      ["Brown", "brown"],
      ["Hazel", "hazel"],
      ["Blue", "blue"],
      ["Green", "green"],
      ["Silver", "silver"],
      ["Amber", "amber"]
    ]
  end

  def hair_color_select
    [
      ["Black", "black"],
      ["Brown", "brown"],
      ["Blond", "blond"],
      ["Auburn", "auburn"],
      ["Chestnut", "chestnut"],
      ["Red", "red"],
      ["Gray", "gray"]
    ]
  end

  def resume_unions
    [
      "Screen Actors Guild"
    ].map do |value|
      OpenStruct.new(id: value, text: value)
    end
  end

  def project_type_select
    [
      ["Film Project", "film"],
      ["Television Project", "television"],
      ["Theater Project", "theater"],
      ["Commercial Project", "commercial"],
      ["Voice Over Project", "voice_over"],
      ["Industrial Project", "industrial"],
    ]
  end

  def project_type_name(project_type)
    {
      "film" => "Film Project",
      "television" => "Television Project",
      "theater" => "Theater Project",
      "commercial" => "Commercial Project",
      "voice_over" => "Voice Over Project",
      "industrial" => "Industrial Project"
    }[project_type]
  end

  def education_type_select
    [
      ["University", "university"],
      ["College", "college"],
      ["Studio", "studio"],
      ["Academy", "academy"],
      ["Private Training", "private_training"]
    ]
  end

  def education_type_name(education_type)
    {
      "university" => "University",
      "college" => "College",
      "studio" => "Studio",
      "academy" => "Academy",
      "private_training" => "Private Training"
    }[education_type]
  end
end
