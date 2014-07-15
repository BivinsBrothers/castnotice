class CreateCritique
  include Interactor

  def perform
    critique = user.critiques.build(critique_attributes)
    context[:critique] = critique
    unless critique.save
      fail!(error: critique.errors.full_messages.join(", "))
    end
  end

  def rollback
    critique.delete
  end
end
