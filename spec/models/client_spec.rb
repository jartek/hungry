require 'rails_helper'

describe Client, type: :model do
  subject { described_class.new }

  describe 'Associations' do
    it { should have_many :restaurants }
  end

  describe "callbacks" do
    it "sets role after initializing" do
      expect(subject.role).to eq('client')
    end
  end
end
