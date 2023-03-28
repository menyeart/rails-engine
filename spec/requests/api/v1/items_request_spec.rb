require 'rails_helper'

describe "Rails API" do
  it "sends a list of items" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)
    item_3 = create(:item, merchant_id: merchant_1.id)

    get '/api/v1/items'
    items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it "can get one item by its id" do
    merchant_1 = create(:merchant)
    item = create(:item, merchant_id: merchant_1.id)

    get "/api/v1/items/#{item.id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
  end

  it "it shows an error if there is no item with the id" do
    get "/api/v1/items/1"
    item = JSON.parse(response.body, symbolize_names: true)
   
    expect(item[:message]).to eq("your query could not be completed")
    expect(item[:error]).to eq("Couldn't find Item with 'id'=1")
  end
end