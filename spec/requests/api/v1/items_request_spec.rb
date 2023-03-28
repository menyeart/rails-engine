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
    # expect(item[:error]).to eq("Couldn't find Item with 'id'=1")
  end

  it "it can create an item" do
    merchant_1 = create(:merchant, id: 5)
    item_params = ({
      name: 'Thingy from Amazon',
      description: 'Whateva',
      unit_price: 120.50,
      merchant_id: 5
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    item = Item.last
    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "it shows an error if an item cannot be created" do
    merchant_1 = create(:merchant, id: 5)
    item_params = ({
      description: 'Whateva',
      unit_price: 120.50,
      merchant_id: 5
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    
    response = post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    item = Item.last

    expect(item).to eq(nil)
  end

  it "it can update an item" do
    merchant_1 = create(:merchant, id: 5)
    item_1 = create(:item, merchant_id: 5)
    previous_name = item_1.name
    item_params = ({name: 'Thingy from Amazon'})
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item_1.id}", headers: headers, params: JSON.generate(item: item_params)
    item = Item.find_by(id: item_1.id)
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq('Thingy from Amazon')


  end
end