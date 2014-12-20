class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
