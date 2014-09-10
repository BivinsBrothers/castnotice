class CreateUser
  include Interactor

  def call
    context.user = User.new(context.user_attributes)
    context.user.build_resume
    context.fail! unless context.user.save
  end

  def rollback
    context.user.destroy
  end
end
