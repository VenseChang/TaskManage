class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :show, :destroy]
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end
  
  def create
    user = User.first
    @task = Task.new(task_params)
    @task.users << user
    return redirect_to tasks_path, notice: I18n.t(:new_success_msg, scope: :common) if @task.save
    flash[:notice] = I18n.t(:new_failed_msg, scope: :common)
    render :new
  end
  
  def edit
  end
  
  def update
    return redirect_to tasks_path, notice: I18n.t(:update_success_msg, scope: :common) if @task.update(task_params)
    flash[:notice] = I18n.t(:update_failed_msg, scope: :common)
    render :edit
  end
  
  def show
  end
  
  def destroy
    flash[:notice] = (@task.destroy) ? I18n.t(:destroy_success_msg, scope: :common) : I18n.t(:destroy_failed_msg, scope: :common)
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
