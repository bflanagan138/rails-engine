require 'rails_helper'

describe "item merchant" do

  it 'returns all merchant info for an item id' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    items1 = create_list(:item, 6, merchant_id: merchant1.id)
    items2 = create_list(:item, 2, merchant_id: merchant2.id)
    item1 = items1.first
  
    get "/api/v1/items/#{item1.id}/merchant"
    item_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item_merchant[:data][:attributes]).to be_a (Hash)
    expect(item_merchant[:data][:attributes][:name]).to eq (merchant1.name)
  end

  it 'returns a 404 error for an incorrect item id' do
    merchant1 = create(:merchant)

    items = create_list(:item, 6, merchant_id: merchant1.id)
    itemlast = items.last
  
    get "/api/v1/items/#{itemlast.id + 1}/merchant"
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq ("Couldn't find Item with 'id'=#{itemlast.id + 1}")
  end
end
