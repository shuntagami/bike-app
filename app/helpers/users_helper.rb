module UsersHelper
  # @userがcurrent_userかどうか
  def current_user?(user)
    user == current_user
  end
end
