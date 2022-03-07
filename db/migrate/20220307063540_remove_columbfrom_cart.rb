class RemoveColumbfromCart < ActiveRecord::Migration[6.0]
  def change
    remove_column :carts, :quantity
    remove_column :carts, :product_id
  end
end
