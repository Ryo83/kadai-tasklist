class Task < ApplicationRecord
    #statusカラムの空白を禁止、文字制限10文字
    validates :status, presence: true, length: { maximum: 10 }
    #contentカラムの空白を禁止、文字制限255文字
    validates :content, presence: true, length: { maximum: 255 }
    #taskモデル(=tasksテーブル)は、userモデル(=usersテーブル)に属している(または、関連している)
    belongs_to :user
end