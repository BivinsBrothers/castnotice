module PerformanceSkillsByCategoryHelper

  def grouped_performance_skills
    @grouped_performance_skills ||= PerformanceSkill.all.to_a.group_by(&:category).sort
  end

end
