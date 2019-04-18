class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if logged_in?
      @title = "タスク一覧"
      # @task = Task.find(5)
      @task = Task.new
      @tasks = Task.all.page(params[:page]).per(3)
    else
      redirect_to login_path
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    # redirect_to "http://yahoo.co.jp" and return
    @task = Task.new(task_params)
    # current_userはログインしているUser自身のインスタンスが入っている
    # SessionsHelperのメソッドとして定義されており、それをApplicationControllerにMix-inしている
    # それをTasksController内で継承しているので、ここでもそのメソッドを使用することができる。
    @task.user_id = current_user.id
    # @task.user = current_user
    
    # @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end

  end
  
  def edit
  end
  
  def update
    # redirect_to "http://yahoo.com/" and return
    if @task.update(task_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
