class TasksController < ApplicationController
before_action :require_user_logged_in
before_action :set_task, only: [:show, :edit, :update, :destroy]
before_action :correct_user, only: [:destroy, :edit]
    
    def index
        #1ページに25件、降順で表示
        @tasks = Task.order(id: :desc).page(params[:page])
    end
    
    def show
    end 
    
    def new
        @task = Task.new
    end 
    
    # def create
    #   @task = Task.new(task_params)
      
    #   if @task.save
    #     flash[:success] = 'タスクが追加されました'
    #     redirect_to @task
    #   else
    #     flash.now[:danger] = 'タスクは追加できませんでした'
    #     render :new
    #   end
    # end
    
    def create
      @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = 'タスクを追加しました'
        redirect_to root_url
      else
        flash.now[:danger] = 'タスクの追加に失敗しました'
        render 'tasks/index'
      end
    end
    
    def edit
    end 
    
    def update
        if @task.update(task_params)
            flash[:success] = 'Taskは正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskは更新されませんでした'
            render :edit
        end
    end 
    
    def destroy
        @task.destroy
        flash[:success] = 'Taskを削除しました'
        redirect_to tasks_url
    end 
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    #Strong Parameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    end
end