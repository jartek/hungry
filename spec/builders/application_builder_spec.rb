require 'rails_helper'

describe ApplicationBuilder do
  let(:object) { double }
  let(:params) { double }

  subject { described_class.new(object, params) }

  describe "initialization" do
    it "initializes the object" do
      expect(subject.object).to eq object
    end

    it "initializes the params" do
      expect(subject.params).to eq params
    end
  end

  describe "#save!" do
    it "persists the object" do
      expect(object).to receive(:save)
      subject.save!
    end
  end
end
