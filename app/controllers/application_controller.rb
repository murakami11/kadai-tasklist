class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # includeはそのModuleのメソッドを、クラスのインスタンスメソッドとして使用することができる
  # これをMix-inという
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_tasks = user.tasks.count
  end
end