class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text   :description
      t.string :processor
      t.string :operating_system
      t.string :storage
      t.string :display
      t.integer :price, default: 0
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
