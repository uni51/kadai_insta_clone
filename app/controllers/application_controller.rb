class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def require_user_logged_in
    unless logged_in?
      flash[:danger] = 'ログインしてください'
      redirect_to new_session_path
    end
  end
end
