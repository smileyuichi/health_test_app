class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :weights, dependent: :destroy
  has_one :profile, dependent: :destroy
  
  # mealモデルを実装したら実装
  # has_many :meals, dependent: :destroy
end
