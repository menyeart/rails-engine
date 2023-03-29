require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "methods" do
    it "can search for merchants by name, order them by name ascending and return the first one" do
      matty = create(:merchant, name: "Matty")
      mattias = create(:merchant, name: "Mattias")
      matthew = create(:merchant, name: "Matthew")

      expect(Merchant.find_by_name("matt")).to eq(matthew)
    end
  end
end
