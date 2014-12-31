require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :role }
  end

  describe 'associations' do
    it { should have_many :reviews }
  end

  describe "callbacks" do
    it "sets role after initializing" do
      expect(User.new.role).to eq('user')
    end
  end
end
