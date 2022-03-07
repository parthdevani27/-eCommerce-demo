class Order < ApplicationRecord
	enum status: [:pending, :awaiting_payment, :awaiting_shipment, :awaiting_pickup, :awaiting_shipped, :complete, :shipped, :cancelled, :declined, :refunded,]
	belongs_to :user, class_name: "User"
    belongs_to :product, class_name: "Product"
end
