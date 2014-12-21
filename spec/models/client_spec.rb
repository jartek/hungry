require 'rails_helper'

describe Client, type: :model do
  describe 'Associations' do
    it { should have_many :restaurants }
  end
end
