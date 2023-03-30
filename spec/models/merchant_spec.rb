require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name }
  
  end

  describe "methods" do
    it "can search for merchants by name, order them by name ascending and return the first one" do
      matty = create(:merchant, name: "Matty")
      mattias = create(:merchant, name: "Mattias")
      matthew = create(:merchant, name: "Matthew")

      expect(Merchant.find_by_name("matt")).to eq(matthew)
    end

    it "can search for merchants by name, order them by name ascending case insensitive and return the first one" do
      abba = create(:merchant, name: "Abba")
      dabba = create(:merchant, name: "Dabba")
      doo = create(:merchant, name: "doo")

      expect(Merchant.find_by_name("ba")).to eq(abba)
    end
  end
end
