class Order < ApplicationRecord
	belongs_to :user, class_name: "User"
    belongs_to :product, class_name: "Product"
end
