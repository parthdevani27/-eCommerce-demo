class Product < ApplicationRecord
	mount_uploader:image, ImageUploader
	enum active: [:active, :inactive]
end
