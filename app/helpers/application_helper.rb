module ApplicationHelper
  require "ostruct"

  def us_states_select
    Country['US'].states.map do |abbr, names|
      [names["name"], abbr]
    end
  end

  def height_options
    48.upto(84).map do |inches|
      [%{#{inches / 12}'#{inches % 12}"}, inches]
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

  def hair_length_select
    [
      ["Short", "short"],
      ["Medium", "medium"],
      ["Long", "long"],
    ]
  end

  def piercing_select
    [
      ["Yes", "yes"],
      ["No", "no"]
    ]
  end

  def tatoo_select
    [
      ["Yes", "yes"],
      ["No", "no"]
    ]
  end

  def citizen_select
    [
      ["US Citizen", "us citizen"],
      ["Resident Alien", "resident alien"]
    ]
  end

  def agent_type_select
    [
      ["Theatrical", "theatrical"],
      ["Television", "television"],
      ["Film", "film"],
      ["Commercial", "commercial"],
      ["Dance", "dance"],
      ["Modeling/Print", "modeling_print"],
      ["Modeling/High Fashion", "modeling_high_fashion"],
      ["Modeling/Editorial", "modeling_editorial"],
      ["Modeling/Commercial", "modeling_commercial"],
      ["Children's Talent Agent", "childrens_talent_agent"],
    ]
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

  def for_select_by_model(klass)
    klass.all.map { |r| [r.name, r.id] }
  end

  def sentence_for_category_collection(category)
    category.map(&:name).to_sentence
  end
end
