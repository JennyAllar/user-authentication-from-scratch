require './application'

class UserRepository

  def initialize(db)
    @user_table = db[:user]
  end

  def create(user)
    @user_table.insert(email: user_email, password_digest: user_password)
  end
end