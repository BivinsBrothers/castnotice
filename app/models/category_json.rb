class CategoryJson
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
          values: Union.names
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
        values: Hash[skills.map {|skill| [skill.id, skill.name]}]
      }
    end
  end

end
