class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :menu_items, :menu_id
    add_index :menus, :restaurant_id
    add_index :seats, :restaurant_id
  end
end
