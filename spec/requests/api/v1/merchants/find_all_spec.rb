require 'rails_helper'

describe "merchant find_all" do
  it 'returns all merchants matching a query' do
    merchant1 = create(:merchant, name: "Triumph Motorcycles")
    merchant2 = create(:merchant, name: "Norton Motorcycles")
    merchant3 = create(:merchant, name: "Baker Skateboards")
    merchants = [merchant1, merchant2, merchant3]
    
    get "/api/v1/merchants/find_all", params: {name: 'Motorcycles'}
    merchant_data = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant_data[:data].count).to eq(2)
    merchant_names = []
    merchant_data[:data].each do |merchant|
      merchant_names << merchant[:attributes][:name]
    end
    # require 'pry'; binding.pry
    expect(merchant_names).to include("Triumph Motorcycles")
    expect(merchant_names).to include("Norton Motorcycles")
    expect(merchant_names).to_not include("Baker Skateboards")
  end
end
