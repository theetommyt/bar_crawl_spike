class CreateBarDistances < ActiveRecord::Migration
  def change
    create_table :bar_distances do |t|
      t.integer :start_bar_id
      t.integer :end_bar_id
      t.float :distance

      t.timestamps null: false
    end
  end
end
