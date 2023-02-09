require 'rails_helper'

describe "items API" do
  it "sends a list of items" do
    create_list(:item, 6)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(6)
    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price].to_f).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id].to_i).to be_a(Integer)
    end
  end

  it 'returns a single merchant by its id' do
    # merchant = create(:merchant).id
    id = create(:item).id

    get "/api/v1/items/#{id}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id].to_i).to be_an(Integer)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price].to_f).to be_a(Float)
  end

  it "can create a new item" do
    merchant = create(:merchant).id
    item_params = ({
                    name: 'Widget 1',
                    description: 'It slices, it dices',
                    unit_price: 1.99,
                    merchant_id: merchant
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    # require 'pry'; binding.pry
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Thunder Widget" }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)
  
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Thunder Widget")
  end

  it "can delete an existing item" do
    # id = create(:item).id
    # previous_name = Item.last.name
    # item_params = { name: "Thunder Widget" }
    # headers = {"CONTENT_TYPE" => "application/json"}
    item = create(:item)
    # We include this header to make sure that these params are passed as JSON rather than as plain text
    expect(Item.count).to eq(1)
    # require 'pry'; binding.pry
    delete "/api/v1/items/#{item.id}"
    # item = Item.find_by(id: id)
  # require 'pry'; binding.pry
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    # expect(item.name).to eq("Thunder Widget")
  end
end
