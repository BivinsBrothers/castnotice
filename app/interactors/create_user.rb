class CreateUser
  include Interactor

  def perform
    context[:user] = User.new(user_attributes)
    user.create_resume
    fail! unless user.save
  end
end
