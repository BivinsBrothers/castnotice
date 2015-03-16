class CategoryJson
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def generate
    @filters ||= {
      filters:
      [
        {
          label: "Region",
          filter: 'region',
          values: Region.names
        },
        {
          label: "Type of Project",
          filter: 'project',
          values: ProjectType.names
        },
        {
          label: "Union",
          filter: 'union',
          values: Union.names,
          selected_ids: selected_ids_for_union
        }
      ] + skill_filters
    }
  end

  private

  def skill_filters
    PerformanceSkill.all.to_a.group_by(&:category).sort.map do |category, skills|
      {
        label: category.titleize,
        filter: 'performance_skill',
        values: Hash[skills.map {|skill| [skill.id, skill.name]}],
        selected_ids: selected_ids_for_skill(category)
      }
    end
  end

  def selected_ids_for_union
    user.resume.union_ids if user
  end

  def selected_ids_for_skill(category)
    user.resume.performance_skills.select do |skill|
      skill.category == category
    end.map(&:id) if user
  end

end
