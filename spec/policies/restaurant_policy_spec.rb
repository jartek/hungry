require 'rails_helper'

describe RestaurantPolicy do
  subject { described_class }

  let(:restaurant) { Restaurant.new }

  pending 'for a visitor'

  context 'for a registered user' do
    let(:user) { User.new }

    [:create?, :update?, :destroy?].each do |action|
      permissions action do
        it { is_expected.to_not permit(user, restaurant) }
      end
    end

    [:show?, :index?].each do |action|
      permissions action do
        it { is_expected.to permit(user, restaurant) }
      end
    end
  end

  context 'for a client' do
    let(:user) { Client.new }

    [:create?, :update?, :destroy?, :show?, :index?].each do |action|
      permissions action do
        it { is_expected.to permit(user, restaurant) }
      end
    end
  end

  context 'for an admin' do
    let(:user) { Admin.new }

    [:create?, :update?, :destroy?, :show?, :index?].each do |action|
      permissions action do
        it { is_expected.to permit(user, restaurant) }
      end
    end
  end
end
