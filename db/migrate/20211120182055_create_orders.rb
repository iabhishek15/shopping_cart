class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
