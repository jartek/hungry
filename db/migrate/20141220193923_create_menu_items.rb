class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.belongs_to :menu
      t.timestamps
    end
  end
end
