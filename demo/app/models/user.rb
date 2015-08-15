class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# 設定 user 跟 event 之間的資料庫關聯 ( database relationship )
has_many :events

validates :email, :presence => true, :uniqueness => true

end
