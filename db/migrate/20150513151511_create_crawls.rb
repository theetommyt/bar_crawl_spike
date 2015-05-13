class CreateCrawls < ActiveRecord::Migration
  def change
    create_table :crawls do |t|
      t.string :name
      t.integer :shots
      t.text :bars, array: true, default: []

      t.timestamps null: false
    end
  end
end
