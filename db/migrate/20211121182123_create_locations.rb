class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :country
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
