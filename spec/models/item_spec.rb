require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
  end

  describe "methods" do
    it "can search for items by name, order them by name" do
      id = create(:merchant).id
      matty = create(:item, name: "Matty", merchant_id: id)
      mattias = create(:item, name: "Mattias", merchant_id: id)
      matthew = create(:item, name: "Matthew", merchant_id: id)

      expect(Item.search_by_name("matt")).to eq([matthew, mattias, matty])
    end

    it "can search for items by a minimum price" do
      id = create(:merchant).id
      matty = create(:item, name: "Matty", unit_price: 50.55, merchant_id: id)
      mattias = create(:item, name: "Mattias", unit_price: 20.25, merchant_id: id)
      matthew = create(:item, name: "Matthew", unit_price: 30.25, merchant_id: id)
      
      expect(Item.search_by_min_price(25)).to eq([matty, matthew])
    end

    it "can search for items by a maximum price" do
      id = create(:merchant).id
      matty = create(:item, name: "Matty", unit_price: 50.55, merchant_id: id)
      mattias = create(:item, name: "Mattias", unit_price: 20.25, merchant_id: id)
      matthew = create(:item, name: "Matthew", unit_price: 30.25, merchant_id: id)
      
      expect(Item.search_by_max_price(25)).to eq([mattias])
    end

    it "can search for items by both max and min price" do
      id = create(:merchant).id
      matty = create(:item, name: "Matty", unit_price: 50.55, merchant_id: id)
      mattias = create(:item, name: "Mattias", unit_price: 20.25, merchant_id: id)
      matthew = create(:item, name: "Matthew", unit_price: 30.25, merchant_id: id)
      
      expect(Item.search_by_prices(25, 40)).to eq([matthew])
    end
  end
end
