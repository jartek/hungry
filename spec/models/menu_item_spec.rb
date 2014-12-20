require 'rails_helper'

describe MenuItem, type: :model do
  describe "associations" do
    it { should belong_to :menu }
  end
end
