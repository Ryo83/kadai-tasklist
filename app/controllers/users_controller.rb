class UsersController < ApplicationController
  #before_actionは、下に記述されているアクション実行前に作動してくれる処理
  #indexとshowでアクションを実行する前に「ログインユーザーかどうか」の確認をする
  # before_action :require_user_logged_in, only: [:index, :show]
  
  # def index
  #   #「users/index.html.erbを、id降順で表示する」を、@usersに代入(全体処理なので複数形)
  #   # @users = User.order(id: :desc).page(params[:page])
  # end

  # def show
  #   #UserのURL(パラメータ)にあるidを検索して、@userに代入(単体処理なので単数形)
  #   # @user = User.find(params[:id])
  # end

  def new
    #Userのインスタンスを生成し、@userに代入(単体処理なので単数形)
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    #もし@userの更新・保存が成功したら、flashメッセージを表示
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
    #その後、新規作成したページへ強制転送
      redirect_to :login
    else
      #@userの保存が失敗したら、flashメッセージを表示
      # users/new.html.erbを表示する
      flash.now[:danger] = 'ユーザーの登録に失敗しました'
      render :new
    end
  end
  
  #以下に記述しているuser_paramsは、UserControllerクラスでしか利用させない
  private
  
  def user_params
    #Userモデルのname, email, password, password_confirmationのみをパラメータとして受け取る
    #requireで対象モデル(=対象テーブル),permitで対象カラムを指定
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
