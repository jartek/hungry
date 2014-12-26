class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true
      t.text :review, null: false
      t.belongs_to :restaurant, index: true
      t.timestamps null: false
    end
  end
end
