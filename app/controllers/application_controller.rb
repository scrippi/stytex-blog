class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def session_valid?
    unless user_signed_in?
      redirect_to new_user_session_path
      return false
    end

    return true
  end
end
