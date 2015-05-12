class CreateDrinkers < ActiveRecord::Migration
  def change
    create_table :drinkers do |t|
      t.string :name
      t.string :message

      t.timestamps null: false
    end
  end
end
