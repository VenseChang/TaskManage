class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :show, :destroy]
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end
  
  def create
    user = User.find(1)
    @task = Task.new(task_params)
    @task.users << user
    return redirect_to tasks_path if @task.save
    render :new
  end
  
  def edit
  end
  
  def update
    return redirect_to tasks_path if @task.update(task_params)
    render :edit
  end
  
  def show
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_path
  end
  
  private
  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :end_time, :priority, :status, :user_id)
  end
end
