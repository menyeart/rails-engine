require 'rails_helper'

describe "Rails API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

    it "can get one merchant by its id" do
      id = create(:merchant).id
      get "/api/v1/merchants/#{id}"
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to eq(id.to_s)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it "it shows an error if there is no merchant with the id" do
      id = create(:merchant).id
      get "/api/v1/merchants/1"
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(merchant[:error][:id]).to eq(nil)
      expect(merchant[:message]).to eq("Couldn't find Merchant with 'id'=1")
    end

    it "it can list all of a merchants items" do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      item_3 = create(:item, merchant_id: merchant_1.id)
      get "/api/v1/merchants/#{merchant_1.id}/items"
      merchant_items = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      merchant_items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end

    it "it shows an error if there is no merchant with the id" do
      id = create(:merchant).id

      get "/api/v1/merchants/1/items"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(merchant[:error][:id]).to eq(nil)
      expect(merchant[:message]).to eq("Couldn't find Merchant with 'id'=1")
    end

    it "it can find a single merchant by searching for a merchants name" do
      matty = create(:merchant, name: "Matty")
      mattias = create(:merchant, name: "Mattias")
      matthew = create(:merchant, name: "Matthew")

      get "/api/v1/merchants/find?name=matt"
      merchant = JSON.parse(response.body, symbolize_names: true)
     
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id].to_i).to eq(matthew.id)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
      expect(merchant[:data][:attributes][:name]).to eq("Matthew")
    end

    it "it renders a successful response with no merchants found" do
      matty = create(:merchant, name: "Matty")
      mattias = create(:merchant, name: "Mattias")
      matthew = create(:merchant, name: "Matthew")

      get "/api/v1/merchants/find?name=bob"
      
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant[:data]).to eq({})
      expect(merchant[:message]).to eq("Object not found")
    end
end