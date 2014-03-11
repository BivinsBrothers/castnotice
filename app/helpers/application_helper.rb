module ApplicationHelper
  require "ostruct"

  def us_states_select
    Country['US'].states.map do |abbr, names|
      [names["name"], abbr]
    end
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
      ["Comercial Project", "comercial"],
      ["Voice Over Project", "voice_over"],
      ["Industrial Project", "industrial"],
    ]
  end
end
