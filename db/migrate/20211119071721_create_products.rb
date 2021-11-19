class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :processor
      t.string :operating_system
      t.string :memory
      t.string :storage
      t.string :display
      t.integer :price

      t.timestamps
    end
  end
end
