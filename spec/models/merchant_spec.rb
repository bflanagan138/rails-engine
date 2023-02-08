require 'rails_helper'

RSpec.describe Merchant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'instance methods' do
    it 'returns all items for a merchant' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      items1 = create_list(:item, 6, merchant_id: merchant1.id)
      items2 = create_list(:item, 2, merchant_id: merchant2.id)
      
      expect(merchant1.all_items.count).to eq (6)
    end
  end
end
