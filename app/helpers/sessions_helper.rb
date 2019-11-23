module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  def logged_in?
    !current_user.nil?
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  def admin_module name_module
    permit = current_user.user_profile.access[name_module].values.include? true
    permit
  end
  def can_action? name_module, name_action
    can = current_user.user_profile.access[name_module][name_action]
  end
end
