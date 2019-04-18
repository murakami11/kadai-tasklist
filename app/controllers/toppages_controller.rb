class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page])
    end
  end
end