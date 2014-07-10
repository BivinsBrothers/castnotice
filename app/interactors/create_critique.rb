class CreateCritique
  include Interactor

  def perform
    critique = user.critiques.build(critique_attributes)
    if critique.save
      context[:critique] = critique
    else
      fail!(error: critique.errors)
    end
  end

  def rollback
    critique.delete
  end
end