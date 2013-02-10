class AddProductFilterFields < ActiveRecord::Migration
  def up
    change_table :spree_products do |t|
      t.boolean :is_sold, :default => false
      t.date :discontinue_on
    end
    Spree::Product.update_all ["is_sold = ?", true]
  end

  def down
    remove_column :spree_products, :is_sold
    remove_column :spree_products, :discontinue_on
  end
end
