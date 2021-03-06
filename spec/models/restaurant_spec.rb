require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "associations" do
    it { should have_one :menu }
    it { should have_many :seats }
    it { should have_many :reviews }
    it { should belong_to :client }
  end
end
