class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private
    
    #require_user_logged_inメソッドを作成
    def require_user_logged_in
        #logged_in?メソッドは、「現在のユーザーがログインしているかどうか」を判別するもの
        #もしログインユーザーじゃなかったら、login画面に強制転送しますよ
        unless logged_in?
            redirect_to login_url
        end
    end
end
