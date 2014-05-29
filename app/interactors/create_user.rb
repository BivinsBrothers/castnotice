class CreateUser
  include Interactor

  perform do
    user = User.new(context[:user_attributes])
    user.create_resume
    fail! unless user.save
    context[:user] = user
  end
end
