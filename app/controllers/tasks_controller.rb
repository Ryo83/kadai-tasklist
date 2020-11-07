class TasksController < ApplicationController
  #全アクション実行前に、ログインユーザーかどうかの確認を行う
  before_action :require_user_logged_in
  
  #set_task必要か？いらない気がする
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  #destroy, editアクション前に、「そのタスクがログインユーザーによって生成されたものかどうか」を確認する
  before_action :correct_user, only: [:destroy, :edit]
    
    def index
        #Task.orderだと、tasksテーブルにある情報を全て取得してきてしまう
        #tasksテーブルにある、ログインユーザーの情報のみを取得したい場合は、14行目のように記述する
        # @tasks = Task.order(id: :desc).page(params[:page])
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    
    def show
    end 
    
    def new
        @task = Task.new
    end 
    
    
    def create
      #buildの書き方は、親モデル.子モデル.buildで記述する
      #今回の場合、current_user(ログインしてるユーザーで、tasksテーブルに新規作成する処理)
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
    
    #correct_user=正しいユーザー
    def correct_user
      #current_userは、cookieに保存されたユーザーidを元に、ユーザーの情報を取得するメソッ
      #tasks.find_by(id: params[:id])なので、tasksテーブルからユーザーを探すメソッド
      
      #つまり、「ログインユーザーidとtasksテーブルのuser_idが一致しているか確認する処理」を、@taskに代入
      @task = current_user.tasks.find_by(id: params[:id])
      #tasksテーブルのuser_idとログインユーザーidが一致しなかったら、トップ画面にリダイレクトする
      unless @task
        redirect_to root_url
      end
    end
end