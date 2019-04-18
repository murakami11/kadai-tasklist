module SessionsHelper
  # ヘルパーモジュールの内容は、Viewでは宣言無しに使用することができる
  def current_user
    # ログインしているユーザーのインスタンスを取得している
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end