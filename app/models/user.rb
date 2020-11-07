class User < ApplicationRecord
    #before_saveは、Userレコードを保存する前に実行するよという意
    #self.email.downcaseは文字をすべて小文字に変換するという意
    #!がつくことで、入力した値そのものを変換する処理をする(=破壊的メソッド)
    #!がないと、その場では小文字に変換されるが、保存された内容は大文字のままなんてことがある
    before_save { self.email.downcase! }
    #nameは空白禁止、文字制限50文字
    validates :name, presence: true, length: { maximum: 50 }
    #emailは空白禁止、文字制限255文字
    validates :email, presence: true, length: { maximum: 255 },
    #emailの文字列?が正しいかのチェック用
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    #uniquenessは、同じ値を持つレコードが既にテーブルに存在しないかをチェックするもの
    #case_sensitive: は、大文字小文字を区別するかどうか。falseなので「大文字小文字を区別しない」
    uniqueness: { case_sensitive: false }
    
    #ログイン認証するなら、絶対に記述するもの
    has_secure_password
    
    #userモデル(=usersテーブル)は、taskモデル(=tasksテーブル)の親テーブルである(関連している)
    has_many :tasks
end