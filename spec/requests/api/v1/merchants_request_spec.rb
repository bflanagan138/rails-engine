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
end