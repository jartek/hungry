require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  it_behaves_like "an api resource", resource: "review", nested_resource: "restaurant"
end
