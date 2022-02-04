require "rails_helper"

describe Slang::Activities do
  subject(:service) { described_class.new }

  describe "get_activities" do
    it "finds activities" do
      expect(subject.get_activities).to eq(nil)
    end
  end
end