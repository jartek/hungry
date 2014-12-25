require 'rails_helper'
require_relative "shared_examples/api_resource_spec"

describe RestaurantController, type: :controller do
  it_behaves_like "api resource", resource: 'restaurant'
end
