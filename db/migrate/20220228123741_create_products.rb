class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :image, null: true
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.text :description  , null: true
      t.integer :active  , null: true
      t.timestamps
    end
  end
end
