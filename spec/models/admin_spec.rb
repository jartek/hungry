require 'rails_helper'

describe Admin, type: :model do
  describe "callbacks" do
    it "sets role after initializing" do
      expect(subject.role).to eq('admin')
    end
  end
end
