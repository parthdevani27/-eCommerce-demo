class Cart < ApplicationRecord
    belongs_to :user, class_name: "User"
    has_many :cartItems, dependent: :destroy
end
