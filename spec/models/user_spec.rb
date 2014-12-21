require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :role }
  end

  context 'Admin' do

  end

  context 'Client' do

  end

  context 'User' do

  end
end
