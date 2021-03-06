class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders, dependent: :destroy
  has_one :cart
  has_many :cartItems, through: :cart
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
