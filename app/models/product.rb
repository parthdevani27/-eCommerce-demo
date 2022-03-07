class Product < ApplicationRecord
	mount_uploader:image, ImageUploader
	enum active: [:active, :inactive]
	has_many :orders
	has_many :cartItems, dependent: :destroy
end
