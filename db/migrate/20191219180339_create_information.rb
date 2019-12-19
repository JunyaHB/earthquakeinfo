class CreateInformation < ActiveRecord::Migration[5.1]
  def change
    create_table :information do |t|
      t.string :location
      t.string :scale
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :disastertime
      t.string :tsunami

      t.timestamps
    end
  end
end
