class CreateCritique
  include Interactor

  def call
    context.critique = context.user.critiques.build(context.critique_attributes)
    unless context.critique.save
      context.fail!(error: context.critique.errors.full_messages.join(", "))
    end
  end

  def rollback
    context.critique.delete
  end
end
