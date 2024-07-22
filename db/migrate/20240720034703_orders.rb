class Orders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :order_id
      t.integer :batch_no
      t.integer :line_item_count
      t.string :company_name

      t.timestamps
    end
  end
end
