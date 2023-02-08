require 'rails_helper'

describe "merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 6)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(6)
    merchants[:data].each do |merchant|
      
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'returns a single merchant by its id' do
    
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id].to_i).to be_an(Integer)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'returns all items for a merchant id' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    items1 = create_list(:item, 6, merchant_id: merchant1.id)
    items2 = create_list(:item, 2, merchant_id: merchant2.id)
   
    get "/api/v1/merchants/#{merchant1.id}/items"
    merchant1 = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant1[:data].count).to eq (6)
    expect(merchant1[:data][0][:attributes][:merchant_id]).to eq (items.first.merchant_id)
    expect(merchant1[:data][0][:attributes][:merchant_id]).to_not eq (items2.first.merchant_id)

  end
end