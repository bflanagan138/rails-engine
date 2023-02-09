require 'rails_helper'

describe "merchant items" do

  it 'returns all items for a merchant id' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    items1 = create_list(:item, 6, merchant_id: merchant1.id)
    items2 = create_list(:item, 2, merchant_id: merchant2.id)
   
    get "/api/v1/merchants/#{merchant1.id}/items"
    merchant1 = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    # require 'pry'; binding.pry
    expect(merchant1.count).to eq (6)
    expect(merchant1[0][:merchant_id]).to eq (items1.first.merchant_id)
    expect(merchant1[0][:merchant_id]).to_not eq (items2.first.merchant_id)

  end
end