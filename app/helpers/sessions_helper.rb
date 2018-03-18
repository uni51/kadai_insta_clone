module SessionsHelper
  def current_user
    # @current_user || @current_user = User.find_by(id: session[:user_id])と以下のコードは同じ
    @current_user ||= User.find_by(id: session[:user_id])
    # @current_userが真の場合はそのままにし、偽の場合は右辺の値 User.find_by(id: session[:user_id]) を代入するというもの
  end

  def logged_in?
    # current_user.nil? だと、「current_userがnilの場合（ログインしていない場合）にtrue」を返すが、
    # 先頭に ! をつけると逆になり「current_userがnilではない場合（ログインしている場合）にtrue」を返す
    !current_user.nil?
  end
end
