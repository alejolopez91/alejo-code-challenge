require "rails_helper"

describe Slang::Api do
  subject(:service) { described_class.new }

  describe "new" do
    it "initializes base_url" do
      expect(subject.base_url).to eq("https://api.slangapp.com")
    end

    it "initializes headers" do
      expect(subject.headers[:"Content-Type"]).to eq("application/json")
      expect(subject.headers[:"Authorization"]).to eq("Basic MTU6RmpwbVVTaW9jRmhMMWZYaEQ0TnJWNWtGL2UrUFBOTTlVVm9YY1pOME9laz0=")
    end
  end
end