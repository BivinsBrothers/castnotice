class CreateUser
  include Interactor

  def perform
    context[:user] = User.new(user_attributes)
    user.build_resume
    fail! unless user.save
  end

  def rollback
    user.destroy
  end
end
