require "rails_helper"

describe Slang::Activities do
  subject(:service) { described_class.new }

  describe "get_activities" do
    it "finds activities" do
      # Implement VCR cassette
      expect(HTTParty).to receive(:get)
      subject.get_activities
    end
  end
end