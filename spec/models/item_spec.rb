require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
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


    it "can search for items by both max and min price" do
      id = create(:merchant).id
      matty = create(:item, name: "Matty", unit_price: 50.55, merchant_id: id)
      mattias = create(:item, name: "Mattias", unit_price: 20.25, merchant_id: id)
      matthew = create(:item, name: "Matthew", unit_price: 30.25, merchant_id: id)
      
      expect(Item.search_by_prices(25, 40)).to eq([matthew])
    end

    it "can find all of an item's invoices that only contain that item" do
      cust_id = create(:customer).id
      merch_id = create(:merchant).id
      item = create(:item, merchant_id: merch_id, name: "laptop", unit_price: 100.99 )
      item_2 = create(:item, merchant_id: merch_id, name: "pager", unit_price: 100.99 )
      invoice = create(:invoice, merchant_id: merch_id, customer_id: cust_id)
      invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
      invoice_2 = create(:invoice, merchant_id: merch_id, customer_id: cust_id)
      invoice_item2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
      invoice_item3 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
    
      expect(item.invoices_only_item).to eq([invoice])
    end
  end
end
