require 'rails_helper'

describe RestaurantController, type: :controller do
  it_behaves_like "an api resource", resource: 'restaurant'
end
