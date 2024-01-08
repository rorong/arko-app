class CreateAddressDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :address_details do |t|
      t.string :street
      t.string :landmark
      t.string :state
      t.string :country
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
