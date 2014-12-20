class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
