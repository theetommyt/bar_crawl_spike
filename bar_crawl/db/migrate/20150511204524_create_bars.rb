class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|

      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :license
      t.float :lat
      t.float :long
      t.float :loc

      t.timestamps null: false
    end
  end
end
