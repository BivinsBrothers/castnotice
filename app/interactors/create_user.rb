class CreateUser
  include Interactor

  def perform
    user = User.new(user_attributes)
    user.create_resume
    fail! unless user.save
    context[:user] = user
  end
end
