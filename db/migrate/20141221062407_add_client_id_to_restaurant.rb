class AddClientIdToRestaurant < ActiveRecord::Migration
  def change
    add_reference :restaurants, :client, index: true
  end
end
